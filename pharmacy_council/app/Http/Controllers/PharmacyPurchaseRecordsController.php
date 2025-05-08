<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\dbpharm\Purchase;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use App\Events\ActivityLogged;

class PharmacyPurchaseRecordsController extends Controller
{
    public function index(Request $request)
    {
        // Log the view_purchase_records action
        $selectedPharmacy = $request->input('pharmacy');
        $pharmacyId = $selectedPharmacy ? DB::connection('pharmacy_main')
            ->table('pharmacies')
            ->where('database_connection', $selectedPharmacy)
            ->value('id') : null;

        event(new ActivityLogged(
            auth()->id(),
            'view_purchase_records',
            null,
            null,
            json_encode(['filters' => $request->all()]),
            $request->path(),
            $pharmacyId
        ));

        // Fetch pharmacies for the dropdown
        $pharmacies = DB::connection('pharmacy_main')
            ->table('pharmacies')
            ->select('id', 'name', 'database_connection')
            ->get()
            ->keyBy('database_connection');

        return view('pharmacy.purchase-records', compact('pharmacies'))
            ->with('header', 'Pharmacy Purchase Records');
    }

    public function getWarehouses(Request $request)
    {
        $pharmacyConnection = $request->input('pharmacy');

        \Log::debug('Fetching warehouses for pharmacy', ['pharmacy_connection' => $pharmacyConnection]);

        if (!$pharmacyConnection) {
            \Log::warning('Pharmacy connection not provided in getWarehouses');
            return response()->json(['error' => 'Pharmacy not selected'], 400);
        }

        try {
            if (!array_key_exists($pharmacyConnection, config('database.connections'))) {
                \Log::error("Database connection [{$pharmacyConnection}] not configured in config/database.php");
                return response()->json(['error' => "Database connection [{$pharmacyConnection}] not configured"], 500);
            }

            $warehouses = DB::connection($pharmacyConnection)
                ->table('warehouses')
                ->select('id', 'name')
                ->get()
                ->map(function ($warehouse) use ($pharmacyConnection) {
                    $warehouse->database_connection = $pharmacyConnection;
                    return $warehouse;
                });

            \Log::debug('Warehouses fetched successfully', [
                'pharmacy_connection' => $pharmacyConnection,
                'count' => $warehouses->count()
            ]);

            return response()->json($warehouses);
        } catch (\Exception $e) {
            \Log::error("Failed to fetch warehouses from {$pharmacyConnection}", [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            return response()->json(['error' => 'Failed to fetch warehouses: ' . $e->getMessage()], 500);
        }
    }

    public function fetchPurchaseRecords(Request $request)
    {
        \Log::debug('Fetching purchase records', ['request_data' => $request->all()]);

        $selectedPharmacy = $request->input('pharmacy');
        $selectedWarehouse = $request->input('warehouse');
        $dateRange = $request->input('date');

        if (!$selectedPharmacy) {
            \Log::warning('Pharmacy is required but not provided in fetchPurchaseRecords');
            return response()->json(['error' => 'Pharmacy is required'], 400);
        }

        \Log::debug('Fetching pharmacies from pharmacy_main');
        $pharmacies = DB::connection('pharmacy_main')
            ->table('pharmacies')
            ->select('id', 'name', 'database_connection')
            ->get()
            ->keyBy('database_connection');
        \Log::debug('Pharmacies fetched', ['count' => $pharmacies->count()]);

        // Parse date range
        if ($dateRange) {
            \Log::debug('Parsing date range', ['date_range' => $dateRange]);
            $separator = str_contains($dateRange, ' to ') ? ' to ' : ' - ';
            $dates = explode($separator, $dateRange);

            if (count($dates) !== 2) {
                \Log::warning('Invalid date range format', ['date_range' => $dateRange]);
                $startDate = now()->startOfMonth();
                $endDate = now()->endOfMonth();
            } else {
                try {
                    $startDate = Carbon::createFromFormat('Y-m-d', trim($dates[0]))->startOfDay();
                    $endDate = Carbon::createFromFormat('Y-m-d', trim($dates[1]))->endOfDay();
                    \Log::debug('Date range parsed', [
                        'start_date' => $startDate->toDateTimeString(),
                        'end_date' => $endDate->toDateTimeString()
                    ]);
                } catch (\Exception $e) {
                    \Log::error('Failed to parse date range', [
                        'date_range' => $dateRange,
                        'error' => $e->getMessage()
                    ]);
                    $startDate = now()->startOfMonth();
                    $endDate = now()->endOfMonth();
                }
            }
        } else {
            $startDate = now()->startOfMonth();
            $endDate = now()->endOfMonth();
            \Log::debug('Using default date range', [
                'start_date' => $startDate->toDateTimeString(),
                'end_date' => $endDate->toDateTimeString()
            ]);
        }

        $purchaseRecords = collect();

        try {
            \Log::debug('Building query for Purchase', [
                'pharmacy' => $selectedPharmacy,
                'warehouse' => $selectedWarehouse
            ]);

            $query = Purchase::on($selectedPharmacy)
                ->with('customer')
                ->orderBy('created_at', 'desc');

            if ($selectedWarehouse) {
                $query->where('warehouse_id', $selectedWarehouse);
            }
            $query->whereBetween('created_at', [$startDate, $endDate]);

            $records = $query->get()
                ->map(function ($record) use ($selectedPharmacy, $pharmacies) {
                    $record->pharmacy_name = $pharmacies[$selectedPharmacy]->name;
                    $record->pharmacy_id = $pharmacies[$selectedPharmacy]->id;
                    return $record;
                });

            $purchaseRecords = $purchaseRecords->merge($records);
            \Log::debug('Purchase records fetched', ['count' => $purchaseRecords->count()]);
        } catch (\Exception $e) {
            \Log::error("Failed to fetch purchase records from $selectedPharmacy", [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            return response()->json(['error' => 'Failed to fetch purchase records: ' . $e->getMessage()], 500);
        }

        $perPage = 20;
        $currentPagePurchases = $request->query('purchase_page', 1);
        $purchaseRecords = new LengthAwarePaginator(
            $purchaseRecords->forPage($currentPagePurchases, $perPage),
            $purchaseRecords->count(),
            $perPage,
            $currentPagePurchases,
            ['path' => route('pharmacy.purchase-records.fetch'), 'pageName' => 'purchase_page']
        );

        $html = view('pharmacy.partials.purchase-records-table', compact('purchaseRecords'))->render();

        return response()->json([
            'html' => $html,
            'pagination' => $purchaseRecords->links()->toHtml(),
        ]);
    }
}