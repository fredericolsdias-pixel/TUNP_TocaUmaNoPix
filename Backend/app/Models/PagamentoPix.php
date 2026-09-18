<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PagamentoPix extends Model
{
    use HasFactory;

    protected $table = 'pagamentos_pix';

    protected $fillable = [
        'pedido_id',
        'status',
        'valor',
        'txid',
        'qr_code_payload',
        'expirado_em',
        'confirmado_em',
    ];

    protected $casts = [
        'valor' => 'decimal:2',
        'expirado_em' => 'datetime',
        'confirmado_em' => 'datetime',
    ];

    /**
     * Pedido relacionado ao pagamento
     */
    public function pedido()
    {
        return $this->belongsTo(Pedido::class);
    }
}