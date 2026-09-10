<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pedido extends Model
{
    use HasFactory;

    protected $table = 'pedidos';

    protected $fillable = [
        'musica_id',
        'evento_id',
        'nome_cliente',
        'valor_gorjeta',
        'status',
        'observacao',
        'solicitado_em'
    ];

    protected $casts = [
        'valor_gorjeta' => 'decimal:2',
        'solicitado_em' => 'datetime',
    ];
    public function musica()
    {
        return $this->belongsTo(Musica::class);
    }

    public function evento()
    {
        return $this->belongsTo(Evento::class);
    }

    public function pagamentoPix()
    {
        return $this->hasOne(PagamentoPix::class);
    }
}