<?php

namespace App\Http\Controllers;

use App\Models\Local;
use Illuminate\Http\Request;

class LocalController extends Controller
{
    public function index()
    {
        return response()->json(Local::all(), 200);
    }


    public function create()
    {
        
    }

    
    public function store(Request $request)
    {
        $validated = $request->validate([
            'nome' => 'required|string|max:255',
            'endereco' => 'nullable|string|max:255',
            'complemento' => 'nullable|string|max:255',
            'bairro' => 'nullable|string|max:255',
            'cidade' => 'nullable|string|max:255',
            'estado' => 'nullable|string|max:2',
            'cep' => 'nullable|string|max:10',
            'latitude' => 'nullable|numeric',
            'longitude' => 'nullable|numeric',
        ]);

        $local = Local::create($validated);

        return response()->json($local, 201);
    }

    
    public function show(Local $local)
    {
        return response()->json($local, 200);
    }

   
    public function edit(Local $local)
    {
        
    }

    
    public function update(Request $request, Local $local)
    {
        $validated = $request->validate([
            'nome' => 'sometimes|required|string|max:255',
            'endereco' => 'nullable|string|max:255',
            'complemento' => 'nullable|string|max:255',
            'bairro' => 'nullable|string|max:255',
            'cidade' => 'nullable|string|max:255',
            'estado' => 'nullable|string|max:2',
            'cep' => 'nullable|string|max:10',
            'latitude' => 'nullable|numeric',
            'longitude' => 'nullable|numeric',
        ]);

        $local->update($validated);

        return response()->json($local, 200);
    }


    public function destroy(Local $local)
    {
        $local->delete();

        return response()->json([
            'message' => 'Local removido com sucesso.'
        ], 200);
    }
}