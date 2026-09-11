<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RepertorioShow extends Model
{
    use HasFactory;

    protected $table = 'repertorios_show';

    protected $fillable = [
        'show_id',
        'musica_id',
        'valor_minimo',
        'esta_disponivel',
        'ordem',
    ];

    protected $casts = [
        'valor_minimo' => 'decimal:2',
        'esta_disponivel' => 'boolean',
    ];

    public function show()
    {
        return $this->belongsTo(Show::class);
    }

    public function musica()
    {
        return $this->belongsTo(Musica::class);
    }

    
    public function pedidos()
    {
        return $this->hasMany(Pedido::class);
    }
}