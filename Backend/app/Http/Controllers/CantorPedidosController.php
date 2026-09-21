<?php

namespace App\Http\Controllers;

use App\Models\Musico;
use App\Models\Pedido;
use App\Models\Show;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

class CantorPedidosController extends Controller
{
    private function showAtual(Request $request)
    {
        $cantor = $request->user();

        abort_unless($cantor instanceof Musico, 403);

        $show = Show::where('musico_id', $cantor->id)
            ->where('status', 'EM_ANDAMENTO')
            ->orderByDesc('id')
            ->first();

        abort_unless($show, 404, 'Você não possui show em andamento.');

        return $show;
    }

    private function formatarPedido(Pedido $pedido)
    {
        $musica = $pedido->repertorioShow
            ? $pedido->repertorioShow->musica
            : null;

        return [
            'id' => $pedido->id,
            'nome_cliente' => $pedido->nome_cliente,
            'identificador_mesa' => $pedido->identificador_mesa,
            'musica' => $musica ? $musica->titulo : 'Música indisponível',
            'artista' => $musica ? $musica->artista_original : '',
            'mensagem' => $pedido->mensagem,
            'valor_gorjeta' => $pedido->valor_gorjeta,
            'status' => $pedido->status,
            'criado_em' => $pedido->created_at,
        ];
    }

    public function index(Request $request)
    {
        $show = $this->showAtual($request);

        $pedidos = Pedido::with('repertorioShow.musica')
            ->where('show_id', $show->id)
            ->whereIn('status', ['PENDENTE', 'ACEITO', 'TOCANDO'])
            ->orderBy('created_at')
            ->orderBy('id')
            ->get();

        $historico = Pedido::with('repertorioShow.musica')
            ->where('show_id', $show->id)
            ->whereIn('status', ['CONCLUIDO', 'RECUSADO', 'CANCELADO'])
            ->orderByDesc('updated_at')
            ->limit(20)
            ->get();

        return response()->json([
            'data' => [
                'show_id' => $show->id,
                'ao_vivo' => $pedidos
                    ->where('status', 'TOCANDO')
                    ->map(function ($pedido) {
                        return $this->formatarPedido($pedido);
                    })
                    ->first(),
                'fila' => $pedidos
                    ->whereIn('status', ['PENDENTE', 'ACEITO'])
                    ->map(function ($pedido) {
                        return $this->formatarPedido($pedido);
                    })
                    ->values(),
                'historico' => $historico
                    ->map(function ($pedido) {
                        return $this->formatarPedido($pedido);
                    })
                    ->values(),
            ],
        ]);
    }

    public function mudarStatus(Request $request, $pedidoId)
    {
        $dados = $request->validate([
            'status' => [
                'required',
                Rule::in(['ACEITO', 'TOCANDO', 'CONCLUIDO', 'RECUSADO']),
            ],
        ]);

        $show = $this->showAtual($request);
        $cantor = $request->user();

        $resultado = DB::transaction(function () use (
            $show,
            $cantor,
            $pedidoId,
            $dados
        ) {
            // Serializa alterações de pedidos deste show.
            Show::where('id', $show->id)
                ->where('musico_id', $cantor->id)
                ->lockForUpdate()
                ->firstOrFail();

            $pedido = Pedido::where('id', $pedidoId)
                ->where('show_id', $show->id)
                ->lockForUpdate()
                ->firstOrFail();

            $permitidos = [
                'PENDENTE' => ['ACEITO', 'RECUSADO'],
                'ACEITO' => ['TOCANDO', 'RECUSADO'],
                'TOCANDO' => ['CONCLUIDO'],
            ];

            $origem = $pedido->status;
            $destino = $dados['status'];

            if (!in_array($destino, $permitidos[$origem] ?? [], true)) {
                return [
                    'erro' => 'Mudança de status não permitida.',
                ];
            }

            if ($destino === 'TOCANDO') {
                $outroAoVivo = Pedido::where('show_id', $show->id)
                    ->where('status', 'TOCANDO')
                    ->where('id', '!=', $pedido->id)
                    ->exists();

                if ($outroAoVivo) {
                    return [
                        'erro' => 'Conclua a música ao vivo antes de iniciar outra.',
                    ];
                }
            }

            $pedido->update(['status' => $destino]);

            DB::table('pedido_status_logs')->insert([
                'pedido_id' => $pedido->id,
                'musico_id' => $cantor->id,
                'responsavel' => $cantor->nome_artistico,
                'status_anterior' => $origem,
                'status_novo' => $destino,
                'alterado_em' => now(),
            ]);

            return [
                'pedido' => $this->formatarPedido(
                    $pedido->load('repertorioShow.musica')
                ),
            ];
        }, 3);

        if (isset($resultado['erro'])) {
            return response()->json([
                'message' => $resultado['erro'],
            ], 409);
        }

        return response()->json([
            'data' => $resultado['pedido'],
        ]);
    }
}