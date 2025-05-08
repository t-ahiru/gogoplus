<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\dbpharm\Purchase;
use App\Models\dbpharm\Product;
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
            $warehouses = DB::connection($pharmacyConnection)
                ->table('warehouses')
                ->select('id', 'name')
                ->get()
                ->map(function ($warehouse) use ($pharmacyConnection) {
                    return [
                        'id' => $warehouse->id,
                        'name' => $warehouse->name,
                        'database_connection' => $pharmacyConnection
                    ];
                });
    
            \Log::debug('Warehouses fetched successfully', [
                'pharmacy_connection' => $pharmacyConnection,
                'count' => $warehouses->count(),
                'warehouses' => $warehouses->toArray()
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

    public function searchProducts(Request $request)
    {
        $pharmacyConnection = $request->input('pharmacy');
        $warehouseId = $request->input('warehouse');
        $term = $request->input('term');

        \Log::debug('Searching products', [
            'pharmacy_connection' => $pharmacyConnection,
            'warehouse_id' => $warehouseId,
            'term' => $term
        ]);

        if (!$pharmacyConnection) {
            \Log::warning('Pharmacy connection not provided in searchProducts');
            return response()->json(['error' => 'Pharmacy not selected'], 400);
        }

        if (!$warehouseId) {
            \Log::warning('Warehouse ID not provided in searchProducts');
            return response()->json(['error' => 'Warehouse not selected'], 400);
        }

        try {
            $products = Product::on($pharmacyConnection)
                ->where('warehouse_id', $warehouseId)
                ->where('name', 'like', '%' . $term . '%')
                ->select('id', 'name')
                ->get()
                ->map(function ($product) {
                    return [
                        'id' => $product->id,
                        'label' => $product->name,
                        'value' => $product->name
                    ];
                });

            \Log::debug('Products fetched successfully', [
                'pharmacy_connection' => $pharmacyConnection,
                'count' => $products->count()
            ]);

            return response()->json($products);
        } catch (\Exception $e) {
            \Log::error("Failed to fetch products from {$pharmacyConnection}", [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            return response()->json(['error' => 'Failed to fetch products: ' . $e->getMessage()], 500);
        }
    }

    public function fetchPurchaseRecords(Request $request)
    {
        \Log::debug('Fetching purchase records', ['request_data' => $request->all()]);
    
        $selectedPharmacy = $request->input('pharmacy');
        $selectedDrug = $request->input('drug');
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
                'drug' => $selectedDrug,
                'warehouse' => $selectedWarehouse
            ]);
    
            $query = Purchase::on($selectedPharmacy)
                ->with(['customer', 'productPurchases.product'])
                ->orderBy('created_at', 'desc');
    
            // Check if the purchases table has a warehouse_id column
            $hasWarehouseColumn = DB::connection($selectedPharmacy)
                ->getSchemaBuilder()
                ->hasColumn('purchases', 'warehouse_id');
    
            if ($hasWarehouseColumn && $selectedWarehouse) {
                \Log::debug('Applying warehouse filter', ['warehouse_id' => $selectedWarehouse]);
                $query->where('warehouse_id', $selectedWarehouse);
            } else {
                \Log::debug('Skipping warehouse filter', [
                    'has_warehouse_column' => $hasWarehouseColumn,
                    'selected_warehouse' => $selectedWarehouse
                ]);
            }
    
            $query->whereBetween('created_at', [$startDate, $endDate]);
    
            if ($selectedDrug) {
                \Log::debug('Filtering by product_id', ['product_id' => $selectedDrug]);
                $query->whereHas('productPurchases', function ($q) use ($selectedDrug) {
                    $q->where('product_id', $selectedDrug);
                });
            }
    
            \Log::debug('Purchase query SQL', [
                'sql' => $query->toSql(),
                'bindings' => $query->getBindings()
            ]);
    
            $records = $query->get()
                ->map(function ($record) use ($selectedPharmacy, $pharmacies) {
                    $record->pharmacy_name = $pharmacies[$selectedPharmacy]->name ?? 'Unknown Pharmacy';
                    $record->pharmacy_id = $pharmacies[$selectedPharmacy]->id ?? null;
                    return $record;
                });
    
            $purchaseRecords = $purchaseRecords->merge($records);
            \Log::debug('Purchase records fetched', [
                'count' => $purchaseRecords->count(),
                'records' => $records->toArray()
            ]);
        } catch (\Exception $e) {
            \Log::error("Failed to fetch purchase records from $selectedPharmacy", [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            $purchaseRecords = collect([]);
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