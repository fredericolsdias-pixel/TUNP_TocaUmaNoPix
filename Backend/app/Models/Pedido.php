<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pedido extends Model
{
    use HasFactory;

    protected $table = 'pedidos';

    protected $fillable = [
        'show_id',
        'repertorio_show_id',
        'nome_cliente',
        'identificador_musica',
        'identificador_mesa',
        'mensagem',
        'valor_gorjeta',
        'status'
    ];

    protected $casts = [
        'valor_gorjeta' => 'decimal:2',
    ];
    
    public function show()
    {
        return $this->belongsTo(Show::class);
        }
        
        public function repertorioShow()
        {
            return $this->belongsTo(RepertorioShow::class);
        }
    public function pagamentoPix()
    {
        return $this->hasOne(PagamentoPix::class);
    }
}