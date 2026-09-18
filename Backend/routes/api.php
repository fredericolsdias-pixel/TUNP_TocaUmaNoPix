<?php

use App\Http\Controllers\MusicoController;
use App\Http\Controllers\MusicaController;
use App\Http\Controllers\ShowController;    
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|----------git ----------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::apiResource('musicos',MusicoController::class);
Route::apiResource('musicas',MusicaController::class);
Route::apiResource('shows',ShowController::class);
