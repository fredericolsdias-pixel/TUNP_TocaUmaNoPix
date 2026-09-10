<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateRepertorioShowsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('repertorio_shows', function (Blueprint $table) {
            $table->id();

            $table->foreignId('show_id')
                  ->constrained('shows')
                  ->cascadeOnDelete()
                  ->cascadeOnUpdate();

            $table->foreignId('musica_id')
                  ->constrained('musicas')
                  ->cascadeOnDelete()
                  ->cascadeOnUpdate();

            $table->decimal('valor_minimo', 10, 2)->nullable(); 
            $table->boolean('esta_disponivel')->default(true);
            $table->integer('ordem')->default(0);

            
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
        Schema::dropIfExists('repertorio_shows');
    }
}
