<?php

namespace App\Http\Controllers;

use App\Models\RepertorioShow;
use Illuminate\Http\Request;

class RepertorioShowController extends Controller
{
    public function index()
    {
        return response()->json(
            RepertorioShow::with([
                'show',
                'musica'
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
            'musica_id' => 'required|exists:musicas,id',
            'valor_minimo' => 'sometimes|numeric|min:0',
            'esta_disponivel' => 'sometimes|boolean',
            'ordem' => 'nullable|integer|min:0',
        ]);

        $repertorio = RepertorioShow::create($validated);

        return response()->json($repertorio, 201);
    }
    public function show(RepertorioShow $repertorioShow)
    {
        return response()->json(
            $repertorioShow->load([
                'show',
                'musica',
                'pedidos'
            ]),
            200
        );
    }
    public function edit(RepertorioShow $repertorioShow)
    {
        //
    }
    public function update(Request $request, RepertorioShow $repertorioShow)
    {
        $validated = $request->validate([
            'valor_minimo' => 'sometimes|numeric|min:0',
            'esta_disponivel' => 'sometimes|boolean',
            'ordem' => 'sometimes|integer|min:0',
        ]);

        $repertorioShow->update($validated);

        return response()->json($repertorioShow, 200);
    }
    public function destroy(RepertorioShow $repertorioShow)
    {
        $repertorioShow->delete();

        return response()->json([
            'message' => 'Item removido do repertório com sucesso.'
        ], 200);
    }
    public function porShow($showId)
    {
        $repertorio = RepertorioShow::where('show_id', $showId)
            ->with('musica')
            ->orderBy('ordem')
            ->get();

        return response()->json($repertorio);
    }
}