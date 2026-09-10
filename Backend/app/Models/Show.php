<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Show extends Model
{
    use HasFactory;

    protected $table = 'shows';

    protected $fillable = [
        'musico_id',
        'local_id',
        'nome',
        'nome_local',
        'endereco',
        'cidade',
        'estado',
        'latitude',
        'longitude',
        'status',
        'visibilidade',
        'iniciado_em',
        'encerrado_em',
    ];

    protected $casts = [
        'latitude' => 'decimal:7',
        'longitude' => 'decimal:7',
        'iniciado_em' => 'datetime',
        'encerrado_em' => 'datetime',
    ];


    public function musico()
    {
        return $this->belongsTo(Musico::class);
    }


    public function local()
    {
        return $this->belongsTo(Local::class);
    }

    
    public function repertorios()
    {
        return $this->hasMany(RepertorioShow::class);
    }

   
    public function pedidos()
    {
        return $this->hasMany(Pedido::class);
    }
}