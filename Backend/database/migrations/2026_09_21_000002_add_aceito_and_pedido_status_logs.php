
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class AddAceitoAndPedidoStatusLogs extends Migration
{
    public function up()
    {
        // O seu banco desta etapa é MySQL.
        DB::statement(
            "ALTER TABLE pedidos MODIFY status ENUM(
                'PENDENTE',
                'ACEITO',
                'TOCANDO',
                'CONCLUIDO',
                'RECUSADO',
                'CANCELADO'
            ) NOT NULL DEFAULT 'PENDENTE'"
        );

        Schema::create('pedido_status_logs', function (Blueprint $table) {
            $table->id();

            $table->foreignId('pedido_id')
                ->constrained('pedidos')
                ->cascadeOnDelete();

            $table->foreignId('musico_id')
                ->nullable()
                ->constrained('musicos')
                ->nullOnDelete();

            $table->string('responsavel');
            $table->string('status_anterior', 30);
            $table->string('status_novo', 30);
            $table->timestamp('alterado_em');
        });
    }

    public function down()
    {
        Schema::dropIfExists('pedido_status_logs');

        DB::table('pedidos')
            ->where('status', 'ACEITO')
            ->update(['status' => 'PENDENTE']);

        DB::statement(
            "ALTER TABLE pedidos MODIFY status ENUM(
                'PENDENTE',
                'TOCANDO',
                'CONCLUIDO',
                'RECUSADO',
                'CANCELADO'
            ) NOT NULL DEFAULT 'PENDENTE'"
        );
    }
}