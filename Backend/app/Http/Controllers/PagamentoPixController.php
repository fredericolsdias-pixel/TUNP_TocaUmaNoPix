<?php

namespace App\Http\Controllers;

use App\Models\PagamentoPix;
use Illuminate\Http\Request;

class PagamentoPixController extends Controller
{
    public function index()
    {
        return response()->json(
            PagamentoPix::with('pedido')->get(),
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
            'pedido_id' => 'required|exists:pedidos,id',
            'status' => 'sometimes|string',
            'valor' => 'required|numeric|min:0',
            'txid' => 'nullable|string|max:255',
            'qr_code_payload' => 'nullable|string',
            'expirado_em' => 'nullable|date',
            'confirmado_em' => 'nullable|date',
        ]);

        $pagamento = PagamentoPix::create($validated);

        return response()->json($pagamento, 201);
    }
    public function show(PagamentoPix $pagamentoPix)
    {
        return response()->json(
            $pagamentoPix->load('pedido'),
            200
        );
    }
    public function edit(PagamentoPix $pagamentoPix)
    {
        //
    }
    public function update(Request $request, PagamentoPix $pagamentoPix)
    {
        $validated = $request->validate([
            'status' => 'sometimes|required|string',
            'valor' => 'sometimes|required|numeric|min:0',
            'txid' => 'nullable|string|max:255',
            'qr_code_payload' => 'nullable|string',
            'expirado_em' => 'nullable|date',
            'confirmado_em' => 'nullable|date',
        ]);

        $pagamentoPix->update($validated);

        return response()->json($pagamentoPix, 200);
    }
    public function destroy(PagamentoPix $pagamentoPix)
    {
        $pagamentoPix->delete();

        return response()->json([
            'message' => 'Pagamento removido com sucesso.'
        ], 200);
    }
}