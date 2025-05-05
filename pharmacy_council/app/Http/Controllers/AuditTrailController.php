<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\dbpharm\AuditLog;
use App\Models\dbpharm\Warehouse;
use App\Models\User;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;

class AuditTrailController extends Controller
{
    public function index(Request $request)
    {
        // Fetch pharmacies for display in the UI
        $pharmacies = DB::connection('pharmacy_main')
            ->table('pharmacies')
            ->select('id', 'name', 'database_connection')
            ->get()
            ->keyBy('id');

        // Fetch users for display in the UI
        $users = User::select('id', 'name')->orderBy('name')->get();

        // Fetch warehouses for display in the UI
        $warehouses = collect();
        $pharmacyConnections = $pharmacies->pluck('database_connection', 'id');
        foreach ($pharmacyConnections as $pharmacyId => $connection) {
            try {
                $pharmacyWarehouses = Warehouse::on($connection)
                    ->select('id', 'name')
                    ->get()
                    ->map(function ($warehouse) use ($pharmacyId) {
                        $warehouse->pharmacy_id = $pharmacyId;
                        return $warehouse;
                    });
                $warehouses = $warehouses->merge($pharmacyWarehouses);
            } catch (\Exception $e) {
                \Log::error("Failed to fetch warehouses from {$connection}: " . $e->getMessage());
            }
        }

        // Aggregate audit logs from all pharmacy databases
        $auditLogs = collect();
        foreach ($pharmacyConnections as $pharmacyId => $connection) {
            try {
                $logs = AuditLog::on($connection)
                    ->with(['user', 'warehouse'])
                    ->orderBy('id', 'asc') // Match sample data sorting
                    ->get()
                    ->map(function ($log) use ($connection, $pharmacies, $pharmacyId) {
                        $log->connection = $connection;
                        $log->pharmacy_name = $pharmacies[$pharmacyId]->name ?? 'N/A';
                        return $log;
                    });
                $auditLogs = $auditLogs->merge($logs);
            } catch (\Exception $e) {
                \Log::error("Failed to fetch audit logs from {$connection}: " . $e->getMessage());
            }
        }

        // Paginate the aggregated audit logs
        $perPage = 10; // Adjust as needed
        $currentPage = $request->query('page', 1);
        $auditLogs = $auditLogs->sortBy('id'); // Ensure consistent sorting
        $auditLogsPaginated = new LengthAwarePaginator(
            $auditLogs->forPage($currentPage, $perPage),
            $auditLogs->count(),
            $perPage,
            $currentPage,
            ['path' => route('audit-trail.index')]
        );

        return view('audit-trail.index', compact('auditLogsPaginated', 'users', 'pharmacies', 'warehouses'))
            ->with('header', 'Audit Trail');
    }
}