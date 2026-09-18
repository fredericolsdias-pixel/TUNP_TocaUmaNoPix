<?php

namespace App\Http\Controllers;

use App\Models\Pedido;
use Illuminate\Http\Request;

class PedidoController extends Controller
{
    public function index()
    {
        return response()->json(
            Pedido::with([
                'show',
                'repertorioShow',
                'pagamentoPix'
            ])->get(),
            200
        );
    }
    public function create()
    {
        //
    }
    public function store(Request $request)
    {
        $validated = $request->validate([
            'show_id' => 'required|exists:shows,id',
            'repertorio_show_id' => 'required|exists:repertorio_shows,id',
            'nome_cliente' => 'required|string|max:255',
            'identificador_musica' => 'nullable|string|max:255',
            'mensagem' => 'nullable|string|max:500',
            'valor_gorjeta' => 'nullable|numeric|min:0',
        ]);

        $pedido = Pedido::create($validated);

        return response()->json($pedido, 201);
    }
    public function show(Pedido $pedido)
    {
        return response()->json(
            $pedido->load([
                'show',
                'repertorioShow',
                'pagamentoPix'
            ]),
            200
        );
    }

    public function edit(Pedido $pedido)
    {
        //
    }
    public function update(Request $request, Pedido $pedido)
    {
        $validated = $request->validate([
            'nome_cliente' => 'sometimes|string|max:255',
            'identificador_musica' => 'nullable|string|max:255',
            'mensagem' => 'nullable|string|max:500',
            'valor_gorjeta' => 'sometimes|numeric|min:0',
            'status' => 'sometimes|string',
        ]);

        $pedido->update($validated);

        return response()->json($pedido, 200);
    }
    public function destroy(Pedido $pedido)
    {
        $pedido->delete();

        return response()->json([
            'message' => 'Pedido removido com sucesso.'
        ], 200);
    }
}