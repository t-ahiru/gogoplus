<?php

namespace App\Http\Controllers;

use App\Models\Pharmacy;
use App\Models\ProductSale;
use Illuminate\Http\Request;
use App\Services\DatabaseSwitcher;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Carbon\Carbon;

class SalesTrendController extends Controller
{
    protected $databaseSwitcher;

    public function __construct(DatabaseSwitcher $databaseSwitcher)
    {
        $this->databaseSwitcher = $databaseSwitcher;
    }

    public function index()
    {
        $pharmacies = Pharmacy::all();
        return view('drugs.sales_trend', compact('pharmacies'));
    }

    public function fetchSalesData(Request $request)
    {
        $request->validate([
            'drugName' => 'required|string|max:255',
            'pharmacy' => 'required|string',
            'timeFrame' => 'required|in:7,30,90,365',
        ]);
    
        $drugName = $request->drugName;
        $pharmacyId = $request->pharmacy;
        $timeFrame = (int)$request->timeFrame;
    
        // Calculate date range
        $dateFrom = Carbon::today()->subDays($timeFrame)->format('Y-m-d');
        $dateTo = Carbon::today()->format('Y-m-d');
    
        // Initialize arrays for chart data
        $dates = [];
        $quantities = [];
        $currentDate = Carbon::parse($dateFrom);
        $endDate = Carbon::parse($dateTo);
    
        while ($currentDate <= $endDate) {
            $dates[] = $currentDate->format('M d');
            $quantities[] = 0;
            $currentDate->addDay();
        }
    
        try {
            Log::info("Switching to pharmacy: {$pharmacyId}");
            $this->databaseSwitcher->switchToPharmacy($pharmacyId);
    
            // Corrected query structure
            $salesData = DB::connection('pharmacy_dynamic')
                ->table('product_sales')
                ->join('sales', 'product_sales.sale_id', '=', 'sales.id')
                ->join('products', 'product_sales.product_id', '=', 'products.id')
                ->where('products.name', 'LIKE', "%{$drugName}%")
                ->whereBetween('sales.created_at', [$dateFrom, $dateTo . ' 23:59:59'])
                ->groupBy(DB::raw('DATE(sales.created_at)'))
                ->orderBy('sales.created_at')
                ->select(
                    DB::raw('DATE(sales.created_at) as sale_date'),
                    DB::raw('SUM(product_sales.qty) as total_qty')
                )
                ->get();
    
            // Populate quantities array
            foreach ($salesData as $data) {
                $formattedDate = Carbon::parse($data->sale_date)->format('M d');
                $index = array_search($formattedDate, $dates);
                if ($index !== false) {
                    $quantities[$index] = (float)$data->total_qty;
                }
            }
    
            return response()->json([
                'status' => 'success',
                'dates' => $dates,
                'quantities' => $quantities,
                'pharmacyName' => Pharmacy::find($pharmacyId)->name ?? 'Selected Pharmacy'
            ]);
        } catch (\Exception $e) {
            Log::error("Failed to query sales data: {$e->getMessage()}");
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to fetch sales data: ' . $e->getMessage()
            ], 500);
        } finally {
            $this->databaseSwitcher->switchToMain();
        }
    }
}