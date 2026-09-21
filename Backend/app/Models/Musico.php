<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class Musico extends Authenticatable
{
  use HasApiTokens, HasFactory, Notifiable;

    protected $table = 'musicos';

    protected $fillable = [
        'nome_artistico',
        'email',
        'password',
        'foto_url',
        'tipo_chave_pix',
        'chave_pix',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];


    public function musicas()
    {
        return $this->hasMany(Musica::class);
    }

  
    public function shows()
    {
        return $this->hasMany(Show::class);
    }
}