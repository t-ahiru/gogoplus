<?php
// app/Http/Controllers/PharmacyMonitorController.php
namespace App\Http\Controllers;

use App\Models\Pharmacy\Sale;
use App\Models\Pharmacy\Product;
use App\Models\Pharmacy\Customer;
use App\Models\Pharmacy\Warehouse;
use Illuminate\Http\Request;
use Carbon\Carbon;

class PharmacyMonitorController extends Controller
{
    public function dashboard()
    {
        // Get today's sales
        $todaySales = Sale::whereDate('created_at', Carbon::today())
            ->with(['products.product', 'customer'])
            ->orderBy('created_at', 'desc')
            ->get();
            
        $todayTotal = $todaySales->sum('grand_total');
        
        // Get monthly sales data for chart
        $monthlySales = Sale::selectRaw('DATE(created_at) as date, SUM(grand_total) as total')
            ->whereBetween('created_at', [Carbon::now()->startOfMonth(), Carbon::now()->endOfMonth()])
            ->groupBy('date')
            ->orderBy('date')
            ->get();
            
        // Get top products
        $topProducts = Product::withCount(['sales as total_sold' => function($query) {
            $query->selectRaw('SUM(qty)');
        }])
        ->orderBy('total_sold', 'desc')
        ->take(5)
        ->get();
        
        return view('pharmacy-monitor.dashboard', compact(
            'todaySales', 
            'todayTotal',
            'monthlySales',
            'topProducts'
        ));
    }
    
    public function salesReport(Request $request)
    {
        $query = Sale::with(['products.product', 'customer', 'warehouse'])
            ->orderBy('created_at', 'desc');
            
        if ($request->has('from_date') && $request->has('to_date')) {
            $query->whereBetween('created_at', [
                Carbon::parse($request->from_date)->startOfDay(),
                Carbon::parse($request->to_date)->endOfDay()
            ]);
        }
        
        $sales = $query->paginate(20);
        
        return view('pharmacy-monitor.sales-report', compact('sales'));
    }
    
    public function productReport(Request $request)
    {
        $query = Product::with(['brand', 'category'])
            ->withCount(['sales as total_sold' => function($query) {
                $query->selectRaw('SUM(qty)');
            }])
            ->withSum(['sales as total_revenue' => function($query) {
                $query->selectRaw('SUM(total)');
            }]);
            
        if ($request->has('search')) {
            $query->where('name', 'like', '%'.$request->search.'%')
                ->orWhere('code', 'like', '%'.$request->search.'%');
        }
        
        $products = $query->paginate(20);
        
        return view('pharmacy-monitor.product-report', compact('products'));
    }
}