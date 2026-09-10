<?php

namespace App\Http\Controllers;

use App\Models\Musico;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class MusicoController extends Controller
{
    public function index()
    {
        return response()->json(
            Musico::all(),
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
            'nome_artistico' => 'required|string|max:255',
            'email' => 'required|email|unique:musicos,email',
            'password' => 'required|string|min:6',
            'foto_url' => 'nullable|string',
            'tipo_chave_pix' => 'required|string',
            'chave_pix' => 'required|string|max:255',
        ]);

        $validated['password'] = Hash::make(
            $validated['password']
        );

        $musico = Musico::create($validated);

        return response()->json($musico, 201);
    }

    public function show(Musico $musico)
    {
        return response()->json(
            $musico->load(['musicas', 'shows']),
            200
        );
    }

    public function edit(Musico $musico)
    {
        //
    }

    public function update(Request $request, Musico $musico)
    {
        $validated = $request->validate([
            'nome_artistico' => 'sometimes|required|string|max:255',
            'email' => 'sometimes|required|email|unique:musicos,email,' . $musico->id,
            'foto_url' => 'nullable|string',
            'tipo_chave_pix' => 'nullable|string',
            'chave_pix' => 'nullable|string|max:255',
        ]);

        $musico->update($validated);

        return response()->json($musico, 200);
    }


    public function destroy(Musico $musico)
    {
        $musico->delete();

        return response()->json([
            'message' => 'Músico removido com sucesso.'
        ], 200);
    }
}