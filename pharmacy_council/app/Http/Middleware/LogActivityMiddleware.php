<?php
namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use App\Models\dbpharm\AuditLog;

class LogActivityMiddleware
{
    public function handle(Request $request, Closure $next)
    {
        $pharmacyId = $request->session()->get('pharmacy_id');
        $pharmacyConnections = [
            1 => 'pharmacy1',
            2 => 'pharmacy2',
            3 => 'pharmacy3',
            4 => 'pharmacy4',
            5 => 'pharmacy5',
        ];

        if (!$pharmacyId || !isset($pharmacyConnections[$pharmacyId])) {
            Log::warning("No pharmacy connection found for pharmacy_id: {$pharmacyId}. Activity not logged.");
            return $next($request);
        }

        $connection = $pharmacyConnections[$pharmacyId];
        try {
            AuditLog::on($connection)->create([
                'user_id' => auth()->id(),
                'action' => 'accessed_page',
                'details' => json_encode(['route' => $request->route()->getName()]),
                'pharmacy_id' => $pharmacyId,
                'created_at' => now(),
            ]);
        } catch (\Exception $e) {
            Log::error("Failed to log activity to {$connection}", [
                'pharmacy_id' => $pharmacyId,
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
        }

        return $next($request);
    }
}