<?php

namespace App\Models\dbpharm;

use Illuminate\Database\Eloquent\Model;

class AuditLog extends Model
{
    protected $table = 'audit_logs';
    protected $connection = null; // Ensure no hardcoded connection

    public function user()
    {
        return $this->belongsTo(\App\Models\User::class, 'user_id');
    }

    public function warehouse()
    {
        return $this->belongsTo(\App\Models\dbpharm\Warehouse::class, 'warehouse_id');
    }
}