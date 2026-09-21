<?php

namespace App\Http\Controllers;

use App\Models\Pedido;
use App\Models\RepertorioShow;
use App\Models\Show;

class PublicShowController extends Controller
{
    public function index()
    {
        $shows = Show::query()
            ->where('visibilidade', 'PUBLICO')
            ->whereIn('status', ['EM_ANDAMENTO', 'PAUSADO'])
            ->with('musico:id,nome_artistico,foto_url')
            ->orderByDesc('iniciado_em')
            ->get()
            ->map(function (Show $show) {
                return $this->formatShow($show);
            });

        return response()->json([
            'data' => $shows,
        ]);
    }

    public function show(Show $show)
    {
        $this->verificarAcessoPublico($show);

        $show->load('musico:id,nome_artistico,foto_url');

        return response()->json([
            'data' => $this->formatShow($show),
        ]);
    }

    public function repertorio(Show $show)
    {
        $this->verificarAcessoPublico($show);

        $repertorio = RepertorioShow::query()
            ->where('show_id', $show->id)
            ->where('esta_disponivel', true)
            ->whereHas('musica', function ($query) {
                $query->where('esta_ativa', true);
            })
            ->with('musica:id,titulo,artista_original,genero')
            ->orderBy('ordem')
            ->orderBy('id')
            ->get()
            ->map(function (RepertorioShow $item) {
                return [
                    'id' => $item->id,
                    'musica_id' => $item->musica_id,
                    'titulo' => $item->musica->titulo,
                    'artista' => $item->musica->artista_original,
                    'categoria' => $item->musica->genero,
                ];
            });

        return response()->json([
            'data' => $repertorio,
        ]);
    }

    public function fila(Show $show)
    {
        $this->verificarAcessoPublico($show);

        $tocando = Pedido::query()
            ->where('show_id', $show->id)
            ->where('status', 'TOCANDO')
            ->with('repertorioShow.musica')
            ->orderByDesc('updated_at')
            ->first();

        $pendentes = Pedido::query()
            ->where('show_id', $show->id)
            ->where('status', 'PENDENTE')
            ->with('repertorioShow.musica')
            ->orderBy('created_at')
            ->orderBy('id')
            ->get()
            ->map(function (Pedido $pedido) {
                return $this->formatPedido($pedido);
            });

        return response()->json([
            'ao_vivo' => $tocando
                ? $this->formatPedido($tocando)
                : null,
            'fila' => $pendentes,
        ]);
    }

    private function verificarAcessoPublico(Show $show)
    {
        abort_unless(
            $show->visibilidade === 'PUBLICO'
                && in_array(
                    $show->status,
                    ['EM_ANDAMENTO', 'PAUSADO'],
                    true
                ),
            404
        );
    }

    private function formatShow(Show $show)
    {
        return [
            'id' => $show->id,
            'nome' => $show->nome,
            'nome_local' => $show->nome_local,
            'cidade' => $show->cidade,
            'estado' => $show->estado,
            'status' => $show->status,
            'iniciado_em' => $show->iniciado_em,
            'musico' => [
                'id' => $show->musico->id,
                'nome_artistico' => $show->musico->nome_artistico,
                'foto_url' => $show->musico->foto_url,
            ],
        ];
    }

    private function formatPedido(Pedido $pedido)
    {
        return [
            'id' => $pedido->id,
            'nome_cliente' => $pedido->nome_cliente,
            'titulo' => $pedido->repertorioShow->musica->titulo,
            'artista' =>
                $pedido->repertorioShow->musica->artista_original,
            'status' => $pedido->status,
            'valor_gorjeta' => $pedido->valor_gorjeta,
            'criado_em' => $pedido->created_at,
        ];
    }
}