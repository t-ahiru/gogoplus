<?php

namespace App\Events;

use Illuminate\Queue\SerializesModels;
use App\Models\dbpharm\ActivityLog;
use Illuminate\Support\Facades\DB;

class ActivityLogged
{
    use SerializesModels;

    public $userId;
    public $actionType;
    public $entityType;
    public $entityId;
    public $payload;
    public $route;
    public $pharmacyId;

    public function __construct($userId, $actionType, $entityType, $entityId, $payload, $route, $pharmacyId)
    {
        $this->userId = $userId;
        $this->actionType = $actionType;
        $this->entityType = $entityType;
        $this->entityId = $entityId;
        $this->payload = $payload;
        $this->route = $route;
        $this->pharmacyId = $pharmacyId;

        // Determine the database connection for the pharmacy
        $connection = null;
        if ($pharmacyId) {
            $connection = DB::connection('pharmacy_main')
                ->table('pharmacies')
                ->where('id', $pharmacyId)
                ->value('database_connection');
        }

        // Log the activity in the correct pharmacy database
        if ($connection) {
            ActivityLog::on($connection)->create([
                'action_id' => $this->userId,
                'action_type' => $this->actionType,
                'entity_type' => $this->entityType,
                'entity_id' => $this->entityId,
                'payload' => $this->payload,
                'route' => $this->route,
                'pharmacy_id' => $this->pharmacyId,
            ]);
        } else {
            \Log::warning("No pharmacy connection found for pharmacy_id: {$pharmacyId}. Activity not logged.");
        }
    }
}