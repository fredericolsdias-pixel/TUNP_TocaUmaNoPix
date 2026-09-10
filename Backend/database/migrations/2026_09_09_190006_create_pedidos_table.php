<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePedidosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('pedidos', function (Blueprint $table) {
            $table->id();

            $table->foreignId('show_id')
                  ->constrained('shows')
                  ->cascadeOnDelete()
                  ->cascadeOnUpdate();

            $table->foreignId('repertorio_show_id')
                  ->constrained('repertorio_shows')
                  ->cascadeOnDelete()
                  ->cascadeOnUpdate();

            $table->string('nome_cliente');
            $table->string('identificador_musica')->nullable();
            $table->text('mensagem')->nullable();

            $table->decimal('valor_gorjeta', 10, 2)->nullable();

            $table->enum('status', [
                'PENDENTE',
                'TOCANDO',
                'CONCLUIDO',
                'RECUSADO',
                'CANCELADO'
            ])->default('PENDENTE');

            
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
        Schema::dropIfExists('pedidos');
    }
}
