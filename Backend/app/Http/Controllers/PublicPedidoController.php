<?php

namespace App\Http\Controllers;

use App\Models\Pedido;
use App\Models\RepertorioShow;
use App\Models\Show;
use Illuminate\Http\Request;

class PublicPedidoController extends Controller
{
    public function store(Request $request, Show $show)
    {
        abort_unless(
            $show->visibilidade === 'PUBLICO'
                && $show->status === 'EM_ANDAMENTO',
            409,
            'Este show não está recebendo pedidos.'
        );

        $dados = $request->validate([
            'repertorio_show_id' => 'required|integer',
            'nome_cliente' => 'required|string|max:100',
            'identificador_mesa' => 'nullable|string|max:30',
            'mensagem' => 'nullable|string|max:500',
            'valor_gorjeta' => [
                'nullable',
                'regex:/^\d{1,8}(\.\d{1,2})?$/',
            ],
        ]);

        $item = RepertorioShow::query()
            ->where('id', $dados['repertorio_show_id'])
            ->where('show_id', $show->id)
            ->where('esta_disponivel', true)
            ->whereHas('musica', function ($query) use ($show) {
                $query->where('esta_ativa', true)
                    ->where('musico_id', $show->musico_id);
            })
            ->firstOrFail();

        $valorGorjeta = $dados['valor_gorjeta'] ?? '0.00';

        $pedido = Pedido::create([
            'show_id' => $show->id,
            'repertorio_show_id' => $item->id,
            'nome_cliente' => $dados['nome_cliente'],
            'identificador_mesa' =>
                $dados['identificador_mesa'] ?? null,
            'mensagem' => $dados['mensagem'] ?? null,
            'valor_gorjeta' => $valorGorjeta,
            'status' => 'PENDENTE',
        ]);

        $pix = null;

        if ((float) $valorGorjeta > 0) {
            $musico = $show->musico;
            $chave = trim((string) $musico->chave_pix);

            // O seeder usa uma chave fictícia: ela nunca deve
            // ser apresentada como chave válida para pagamento.
            $chaveReal = $chave !== ''
                && strpos($chave, 'DEMO_') !== 0;

            if ($chaveReal) {
                $pix = [
                    'tipo_chave' => $musico->tipo_chave_pix,
                    'chave' => $chave,
                    'valor' => $pedido->valor_gorjeta,
                ];
            }
        }

        return response()->json([
            'data' => [
                'id' => $pedido->id,
                'status' => $pedido->status,
                'valor_gorjeta' => $pedido->valor_gorjeta,
                'pix' => $pix,
            ],
        ], 201);
    }
}