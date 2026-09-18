<?php

namespace App\Http\Controllers;

use App\Models\Show;
use Illuminate\Http\Request;

class ShowController extends Controller
{
    public function index()
    {
        return response()->json(
            Show::with([
                'musico',
                'local'
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
            'musico_id' => 'required|exists:musicos,id',
            'local_id' => 'nullable|exists:locais,id',
            'nome' => 'required|string|max:255',
            'nome_local' => 'nullable|string|max:255',
            'endereco' => 'nullable|string|max:255',
            'cidade' => 'nullable|string|max:100',
            'estado' => 'nullable|string|max:2',
            'latitude' => 'nullable|numeric',
            'longitude' => 'nullable|numeric',
            'status' => 'sometimes|string',
            'visibilidade' => 'sometimes|string',
            'iniciado_em' => 'nullable|date',
            'encerrado_em' => 'nullable|date',
        ]);

        $show = Show::create($validated);

        return response()->json($show, 201);
    }
    public function show(Show $show)
    {
        return response()->json(
            $show->load([
                'musico',
                'local',
                'repertorios',
                'pedidos'
            ]),
            200
        );
    }
    public function edit(Show $show)
    {
        //
    }
    public function update(Request $request, Show $show)
    {
        $validated = $request->validate([
            'nome' => 'sometimes|required|string|max:255',
            'nome_local' => 'nullable|string|max:255',
            'endereco' => 'nullable|string|max:255',
            'cidade' => 'nullable|string|max:100',
            'estado' => 'nullable|string|max:2',
            'latitude' => 'nullable|numeric',
            'longitude' => 'nullable|numeric',
            'status' => 'sometimes|string',
            'visibilidade' => 'sometimes|string',
            'iniciado_em' => 'nullable|date',
            'encerrado_em' => 'nullable|date',
        ]);

        $show->update($validated);

        return response()->json($show, 200);
    }
    public function destroy(Show $show)
    {
        $show->delete();

        return response()->json([
            'message' => 'Show removido com sucesso.'
        ], 200);
    }
    public function porMusico($musicoId)
    {
        $shows = Show::where('musico_id', $musicoId)
            ->with('local')
            ->get();

        return response()->json($shows);
    }
    public function iniciar(Show $show)
    {
        $show->update([
            'status' => 'EM_ANDAMENTO',
            'iniciado_em' => now(),
        ]);

        return response()->json($show);
    }
    public function encerrar(Show $show)
    {
        $show->update([
            'status' => 'ENCERRADO',
            'encerrado_em' => now(),
        ]);

        return response()->json($show);
    }
}