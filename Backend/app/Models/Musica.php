<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Musica extends Model
{
    use HasFactory;

    protected $table = 'musicas';

    protected $fillable = [
        'musico_id',
        'titulo',
        'artista_original',
        'genero',
        'e_autoral',
        'esta_ativa',
    ];

    protected $casts = [
        'e_autoral' => 'boolean',
        'esta_ativa' => 'boolean',
    ];

    public function musico()
    {
        return $this->belongsTo(Musico::class);
    }

   
    public function repertoriosShow()
    {
        return $this->hasMany(RepertorioShow::class);
    }
}