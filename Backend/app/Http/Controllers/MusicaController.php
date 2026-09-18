<?php

namespace App\Http\Controllers;

use App\Models\Musica;
use Illuminate\Http\Request;

class MusicaController extends Controller
{

    public function index()
    {
        return response()->json(
            Musica::with('musico')->get(),
            200
        );  
    }

    public function create()
    {
        
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'musico_id' => 'required|exists:musicos,id',
            'titulo' => 'required|string|max:255',
            'artista_original' => 'required|string|max:255',
            'genero' => 'nullable|string|max:100',
            'e_autoral' => 'sometimes|boolean',
            'esta_ativa' => 'sometimes|boolean',
        ]);

        $musica = Musica::create($validated);

        return response()->json($musica, 201);
    }


    public function show(Musica $musica)
    {
        return response()->json(
            $musica->load('musico'),
            200
        );
    }

    public function edit(Musica $musica)
    {
        
    }

    public function update(Request $request, Musica $musica)
    {
        $validated = $request->validate([
            'titulo' => 'sometimes|required|string|max:255',
            'artista_original' => 'sometimes|required|string|max:255',
            'genero' => 'nullable|string|max:100',
            'e_autoral' => 'sometimes|boolean',
            'esta_ativa' => 'sometimes|boolean',
        ]);

        $musica->update($validated);

        return response()->json($musica, 200);
    }

    public function destroy(Musica $musica)
    {
        $musica->delete();

        return response()->json([
            'message' => 'Música deletada com sucesso.'
        ], 200
);
    }
}
