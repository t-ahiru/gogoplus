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
        'month' => 'required|string|size:2',
        'year' => 'required|string|size:4',
    ]);

    $drugName = $request->drugName;
    $pharmacyId = $request->pharmacy;
    $month = $request->month;
    $year = $request->year;

    // Calculate date range for the selected month/year
    $dateFrom = Carbon::createFromDate($year, $month, 1)->startOfMonth();
    $dateTo = $dateFrom->copy()->endOfMonth();

    // Initialize arrays for chart data (daily)
    $dates = [];
    $quantities = [];
    $currentDate = $dateFrom->copy();

    while ($currentDate <= $dateTo) {
        $dates[] = $currentDate->format('M d');
        $quantities[] = 0;
        $currentDate->addDay();
    }

    try {
        $this->databaseSwitcher->switchToPharmacy($pharmacyId);

        $salesData = DB::connection('pharmacy_dynamic')
            ->table('product_sales')
            ->join('sales', 'product_sales.sale_id', '=', 'sales.id')
            ->join('products', 'product_sales.product_id', '=', 'products.id')
            ->where('products.name', 'LIKE', "%{$drugName}%")
            ->whereBetween('sales.created_at', [
                $dateFrom->format('Y-m-d'),
                $dateTo->format('Y-m-d 23:59:59')
            ])
            ->groupBy(DB::raw('DATE(sales.created_at)'))
            ->orderBy('sales.created_at')
            ->select(
                DB::raw('DATE(sales.created_at) as sale_date'),
                DB::raw('SUM(product_sales.qty) as total_qty')
            )
            ->get();

        foreach ($salesData as $data) {
            $formattedDate = Carbon::parse($data->sale_date)->format('M d');
            $index = array_search($formattedDate, $dates);
            if ($index !== false) {
                $quantities[$index] = (float)$data->total_qty;
            }
        }

        return response()->json([
            'status' => 'success',
            'dates' => $dates, // Format: ['Jan 01', 'Jan 02', ...]
            'quantities' => $quantities, // Format: [10, 15, ...]
        ], 200, [
            'Content-Type' => 'application/json',
            'Cache-Control' => 'no-cache'
        ]);

    } catch (\Exception $e) {
        return response()->json([
            'status' => 'error',
            'message' => $e->getMessage()
        ], 500);
    }
 finally {
        $this->databaseSwitcher->switchToMain();
    }
}
}