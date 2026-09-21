<?php

namespace App\Http\Controllers;

use App\Models\Musica;
use App\Models\Musico;
use App\Models\RepertorioShow;
use App\Models\Show;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;

class CantorPainelController extends Controller
{
    public function entrar(Request $request)
    {
        $dados = $request->validate([
            'email' => 'required|email',
            'password' => 'required|string',
        ]);

        $musico = Musico::where('email', $dados['email'])->first();

        if (!$musico || !Hash::check($dados['password'], $musico->password)) {
            return response()->json([
                'message' => 'E-mail ou senha incorretos.',
            ], 401);
        }

        return response()->json([
            'data' => [
                'token' => $musico->createToken('painel-cantor')->plainTextToken,
            ],
        ]);
    }

    private function cantor(Request $request)
    {
        $usuario = $request->user();

        abort_unless($usuario instanceof Musico, 403);

        return $usuario;
    }

    private function showAtual(Request $request)
    {
        $show = Show::where('musico_id', $this->cantor($request)->id)
            ->where('status', 'EM_ANDAMENTO')
            ->orderByDesc('id')
            ->first();

        abort_unless($show, 404, 'Este cantor não possui show em andamento.');

        return $show;
    }

    private function itemDoShow(Request $request, $repertorio)
    {
        return RepertorioShow::with('musica')
            ->where('id', $repertorio)
            ->where('show_id', $this->showAtual($request)->id)
            ->whereHas('musica', function ($query) use ($request) {
                $query->where('musico_id', $this->cantor($request)->id)
                    ->where('esta_ativa', true);
            })
            ->firstOrFail();
    }

    private function formatarItem(RepertorioShow $item)
    {
        return [
            'id' => $item->id,
            'musica_id' => $item->musica_id,
            'titulo' => $item->musica->titulo,
            'artista' => $item->musica->artista_original,
            'genero' => $item->musica->genero,
            'disponivel' => (bool) $item->esta_disponivel,
        ];
    }

    public function meusDados(Request $request)
    {
        $musico = $this->cantor($request);

        $show = Show::where('musico_id', $musico->id)
            ->where('status', 'EM_ANDAMENTO')
            ->orderByDesc('id')
            ->first();

        return response()->json([
            'data' => [
                'nome_artistico' => $musico->nome_artistico,
                'email' => $musico->email,
                'tipo_chave_pix' => $musico->tipo_chave_pix,
                'chave_pix' => $musico->chave_pix,
                'show' => $show ? [
                    'id' => $show->id,
                    'nome' => $show->nome,
                    'nome_local' => $show->nome_local,
                    'status' => $show->status,
                ] : null,
            ],
        ]);
    }

    public function atualizarDados(Request $request)
    {
        $musico = $this->cantor($request);

        $dados = $request->validate([
            'nome_artistico' => 'required|string|max:255',
            'email' => [
                'required',
                'email',
                'max:255',
                Rule::unique('musicos', 'email')->ignore($musico->id),
            ],
            'tipo_chave_pix' => [
                'required',
                Rule::in(['CPF', 'CNPJ', 'EMAIL', 'TELEFONE', 'ALEATORIA']),
            ],
            'chave_pix' => 'required|string|max:255',
        ]);

        $musico->update($dados);

        return $this->meusDados($request);
    }

    public function sair(Request $request)
    {
        $this->cantor($request)->currentAccessToken()->delete();

        return response()->json(['message' => 'Sessão encerrada.']);
    }

    public function repertorio(Request $request)
    {
        $itens = RepertorioShow::with('musica')
            ->where('show_id', $this->showAtual($request)->id)
            ->whereHas('musica', function ($query) use ($request) {
                $query->where('musico_id', $this->cantor($request)->id)
                    ->where('esta_ativa', true);
            })
            ->orderBy('ordem')
            ->orderBy('id')
            ->get();

        return response()->json([
            'data' => $itens->map(function ($item) {
                return $this->formatarItem($item);
            })->values(),
        ]);
    }

    public function adicionarMusica(Request $request)
    {
        $dados = $request->validate([
            'titulo' => 'required|string|max:255',
            'artista_original' => 'required|string|max:255',
            'genero' => 'nullable|string|max:100',
        ]);

        $show = $this->showAtual($request);
        $musico = $this->cantor($request);

        $item = DB::transaction(function () use ($dados, $show, $musico) {
            $musica = Musica::create([
                'musico_id' => $musico->id,
                'titulo' => $dados['titulo'],
                'artista_original' => $dados['artista_original'],
                'genero' => $dados['genero'] ?? null,
                'e_autoral' => false,
                'esta_ativa' => true,
            ]);

            $item = RepertorioShow::create([
                'show_id' => $show->id,
                'musica_id' => $musica->id,
                'esta_disponivel' => true,
                'ordem' => 0,
            ]);

            return $item->load('musica');
        });

        return response()->json([
            'data' => $this->formatarItem($item),
        ], 201);
    }

    public function atualizarMusica(Request $request, $repertorio)
    {
        $item = $this->itemDoShow($request, $repertorio);

        $dados = $request->validate([
            'titulo' => 'sometimes|required|string|max:255',
            'artista_original' => 'sometimes|required|string|max:255',
            'genero' => 'nullable|string|max:100',
            'disponivel' => 'sometimes|required|boolean',
        ]);

        DB::transaction(function () use ($item, $dados) {
            $camposMusica = Arr::only(
                $dados,
                ['titulo', 'artista_original', 'genero']
            );

            if ($camposMusica) {
                $item->musica->update($camposMusica);
            }

            if (array_key_exists('disponivel', $dados)) {
                $item->update([
                    'esta_disponivel' => $dados['disponivel'],
                ]);
            }
        });

        return response()->json([
            'data' => $this->formatarItem($item->fresh('musica')),
        ]);
    }

    public function arquivarMusica(Request $request, $repertorio)
    {
        $item = $this->itemDoShow($request, $repertorio);

        DB::transaction(function () use ($item) {
            $item->update(['esta_disponivel' => false]);
            $item->musica->update(['esta_ativa' => false]);
        });

        return response()->json([
            'message' => 'Música arquivada.',
        ]);
    }
}