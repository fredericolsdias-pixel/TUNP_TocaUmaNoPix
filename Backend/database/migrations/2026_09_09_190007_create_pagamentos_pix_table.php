<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePagamentosPixTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('pagamentos_pix', function (Blueprint $table) {
            $table->id();

            $table->foreignId('pedido_id')
                  ->unique()
                  ->constrained('pedidos')
                  ->cascadeOnDelete()
                  ->cascadeOnUpdate();

            $table->enum('status', [
                'PENDENTE',
                'CONCLUIDO',
                'CANCELADO'
            ])->default('PENDENTE');

            $table->decimal('valor', 10, 2);

            $table->string('txid')->nullable();
            $table->text('qr_code_payload')->nullable();

            $table->dateTime('expirado_em')->nullable();
            $table->datetime('confirmado_em')->nullable();
            
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
        Schema::dropIfExists('pagamentos_pix');
    }
}
