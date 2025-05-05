<?php

namespace App\Models\dbpharm;

use Illuminate\Database\Eloquent\Model;
use App\Models\User;

class ActivityLog extends Model
{
    protected $table = 'action_logs';

    // Remove the fixed connection; we'll set it dynamically
    // protected $connection = 'mysql';

    public function user()
    {
        return $this->belongsTo(User::class, 'action_id');
    }

    public function pharmacy()
    {
        return $this->belongsTo(Pharmacy::class, 'pharmacy_id');
    }

    public function warehouse()
    {
        return $this->belongsTo(Warehouse::class, 'warehouse_id');
    }

    // Optionally, add a method to set the connection dynamically
    public function setConnectionForPharmacy($connection)
    {
        $this->setConnection($connection);
        return $this;
    }
}