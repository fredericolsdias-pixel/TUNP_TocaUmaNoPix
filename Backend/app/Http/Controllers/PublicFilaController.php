<?php

namespace App\Http\Controllers;

use App\Models\Pedido;
use App\Models\Show;

class PublicFilaController extends Controller
{
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
            'valor_gorjeta' => $pedido->valor_gorjeta,
            'status' => $pedido->status,
        ];
    }

    public function index(Show $show)
    {
        abort_unless(
            $show->status === 'EM_ANDAMENTO' &&
            $show->visibilidade === 'PUBLICO',
            404
        );

        $pedidos = Pedido::with('repertorioShow.musica')
            ->where('show_id', $show->id)
            ->whereIn('status', ['PENDENTE', 'ACEITO', 'TOCANDO'])
            ->orderBy('created_at')
            ->orderBy('id')
            ->get();

        return response()->json([
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
        ]);
    }
}