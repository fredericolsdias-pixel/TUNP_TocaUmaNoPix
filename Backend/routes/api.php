<?php

use App\Http\Controllers\PublicShowController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PublicPedidoController;
use App\Http\Controllers\CantorPainelController;
use App\Http\Controllers\CantorPedidosController;
use App\Http\Controllers\PublicFilaController;

Route::prefix('publico')->group(function () {
    Route::get(
        'shows',
        [PublicShowController::class, 'index']
    );

    Route::get(
        'shows/{show}',
        [PublicShowController::class, 'show']
    );

    Route::get(
        'shows/{show}/repertorio',
        [PublicShowController::class, 'repertorio']
    );

    Route::get(
    'shows/{show}/fila',
    [PublicFilaController::class, 'index']
    );

    Route::post(
    'shows/{show}/pedidos',
    [PublicPedidoController::class, 'store']
)->middleware('throttle:10,1');

});

Route::post('/cantor/entrar', [CantorPainelController::class, 'entrar'])
    ->middleware('throttle:10,1');

Route::middleware('auth:sanctum')->prefix('cantor')->group(function () {
    Route::get('/me', [CantorPainelController::class, 'meusDados']);
    Route::put('/me', [CantorPainelController::class, 'atualizarDados']);
    Route::post('/sair', [CantorPainelController::class, 'sair']);

    Route::get('/repertorio', [CantorPainelController::class, 'repertorio']);
    Route::post('/repertorio', [CantorPainelController::class, 'adicionarMusica']);
    Route::patch(
        '/repertorio/{repertorio}',
        [CantorPainelController::class, 'atualizarMusica']
    );
    Route::delete(
        '/repertorio/{repertorio}',
        [CantorPainelController::class, 'arquivarMusica']
    );
});

Route::middleware('auth:sanctum')->prefix('cantor')->group(function () {
    // Mantenha aqui suas rotas atuais de /me, /sair e /repertorio.

    Route::get('/pedidos', [CantorPedidosController::class, 'index']);

    Route::patch(
        '/pedidos/{pedidoId}/status',
        [CantorPedidosController::class, 'mudarStatus']
    );
});