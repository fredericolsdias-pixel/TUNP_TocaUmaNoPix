<?php

namespace Database\Seeders;

use App\Models\Musica;
use App\Models\Musico;
use App\Models\RepertorioShow;
use App\Models\Show;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DemoShowSeeder extends Seeder
{
    public function run()
    {
        $musico = Musico::firstOrCreate(
            [
                'email' => 'artista-demo@example.invalid',
            ],
            [
                'nome_artistico' => 'Artista Demo',
                'password' => Hash::make('demonstracao-sem-acesso'),
                'tipo_chave_pix' => 'ALEATORIA',
                'chave_pix' => 'DEMO_SEM_CHAVE_PIX_REAL',
            ]
        );

        $show = Show::firstOrCreate(
            [
                'musico_id' => $musico->id,
                'nome' => 'Show de demonstração',
            ],
            [
                'nome_local' => 'Local de demonstração',
                'status' => 'EM_ANDAMENTO',
                'visibilidade' => 'PUBLICO',
                'iniciado_em' => now(),
            ]
        );

        $musicas = [
            ['Evidências', 'Chitãozinho & Xororó', 'Sertanejo'],
            ['Boate Azul', 'Bruno & Marrone', 'Sertanejo'],
            ['Pais e Filhos', 'Legião Urbana', 'Rock'],
            ['Anunciação', 'Alceu Valença', 'MPB'],
        ];

        foreach ($musicas as $indice => $dados) {
            $musica = Musica::firstOrCreate(
                [
                    'musico_id' => $musico->id,
                    'titulo' => $dados[0],
                ],
                [
                    'artista_original' => $dados[1],
                    'genero' => $dados[2],
                    'esta_ativa' => true,
                ]
            );

            RepertorioShow::firstOrCreate(
                [
                    'show_id' => $show->id,
                    'musica_id' => $musica->id,
                ],
                [
                    'esta_disponivel' => true,
                    'ordem' => $indice + 1,
                    'valor_minimo' => null,
                ]
            );
        }
    }
}