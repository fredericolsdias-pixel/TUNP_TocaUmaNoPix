<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMusicasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('musicas', function (Blueprint $table) {
            $table->id();

            $table->ForeignId('musico_id')
                  ->constrained('musicos')
                  ->cascadeOnDelete()
                  ->cascadeOnUpdate();

            $table->string('titulo');
            $table->string('artista_original');
            $table->string('genero')->nullable();
            $table->boolean('e_autoral')->default(false);
            $table->boolean('esta_ativa')->default(true);
            
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
        Schema::dropIfExists('musicas');
    }
}
