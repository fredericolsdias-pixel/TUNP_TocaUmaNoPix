<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMusicosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('musicos', function (Blueprint $table) {
            $table->id();
            $table->string('nome_artistico');
            $table->string('email')->unique();
            $table->string('password');
            $table->string('foto_url')->nullable();

            $table->enum('tipo_chave_pix',[
                'CPF',
                'CNPJ',
                'EMAIL',
                'TELEFONE',
                'ALEATORIA'
            ]);

            $table->string('chave_pix');

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('musicos');
    }
}
