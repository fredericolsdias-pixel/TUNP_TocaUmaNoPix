<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateShowsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('shows', function (Blueprint $table) {
            $table->id();

            $table->foreignId('musico_id')
                  ->constrained('musicos')
                  ->cascadeOnDelete()
                  ->cascadeOnUpdate();  

            $table->foreignId('local_id')
                  ->nullable()
                  ->constrained('locals')
                  ->nullOnDelete()
                  ->cascadeOnUpdate();

             $table->string('nome');
             $table->string('nome_local')->nullable();
             $table->string('endereco')->nullable();
             $table->string('cidade')->nullable();
             $table->string('estado')->nullable();

             $table->decimal('latitude',10,7)->nullable();
             $table->decimal('longitude',10,7)->nullable();

             $table->enum('status' , [
                'CONFIGURANDO',
                'EM_ANDAMENTO',
                'PAUSADO',
                'ENCERRADO',
                'CANCELADO'
             ])->default('CONFIGURANDO');

             $table->enum('visibilidade',[
                'PUBLICO',
                'PRIVADO'
             ])->default('PUBLICO');

             $table->dateTime('iniciado_em')->nullable();
             $table->datetime('encerrado_em')->nullable();


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
        Schema::dropIfExists('shows');
    }
}
