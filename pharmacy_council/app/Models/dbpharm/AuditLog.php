<?php

namespace App\Models\dbpharm;

use Illuminate\Database\Eloquent\Model;
use App\Models\User;

class AuditLog extends Model
{
    protected $table = 'audit_logs';

    protected $fillable = [
        'user_id',
        'action',
        'details',
        'pharmacy_id',
        'warehouse_id',
        'created_at',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function warehouse()
    {
        return $this->belongsTo(Warehouse::class, 'warehouse_id');
    }

    public function setConnectionForPharmacy($connection)
    {
        $this->setConnection($connection);
        return $this;
    }
}