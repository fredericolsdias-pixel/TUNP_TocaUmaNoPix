<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Local extends Model
{
    use HasFactory;

    protected $table = 'locals';

    protected $fillable = [
        'nome',
        'endereco',
        'cidade',
        'estado',
        'latitude',
        'longitude',
    ];

    protected $casts = [
        'latitude' => 'decimal:7',
        'longitude' => 'decimal:7',
    ];
    public function shows()
    {
        return $this->hasMany(Show::class);
    }
}