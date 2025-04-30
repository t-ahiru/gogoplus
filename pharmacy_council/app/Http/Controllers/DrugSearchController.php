<?php

namespace App\Http\Controllers;

use App\Models\Pharmacy;
use App\Models\Product;
use App\Services\DatabaseSwitcher;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;

class DrugSearchController extends Controller
{
    protected $databaseSwitcher;

    public function __construct(DatabaseSwitcher $databaseSwitcher)
    {
        $this->databaseSwitcher = $databaseSwitcher;
    }

    public function search(Request $request)
    {
        $query = $request->input('query');
        $perPage = 10;
        $results = collect();

        if (!empty($query)) {
            // Get all pharmacies from the main database
            $pharmacies = Pharmacy::select('id', 'name', 'location')->get();

            foreach ($pharmacies as $pharmacy) {
                try {
                    // Switch to pharmacy database
                    $this->databaseSwitcher->switchToPharmacy($pharmacy->id);

                    // Query available products in the pharmacy database
                    $products = Product::on('pharmacy_dynamic')
                        ->available()
                        ->where('is_active', 1)
                        ->where(function ($q) use ($query) {
                            $q->where('name', 'LIKE', "%{$query}%")
                              ->orWhere('code', 'LIKE', "%{$query}%");
                        })
                        ->with(['category', 'brand', 'shelf', 'unit'])
                        ->get()
                        ->map(function ($product) use ($pharmacy) {
                            return [
                                'product' => $product,
                                'pharmacy' => $pharmacy,
                            ];
                        });

                    $results = $results->merge($products);
                } catch (\Exception $e) {
                    // Log error but continue with other pharmacies
                    \Log::error("Failed to query pharmacy {$pharmacy->id}: {$e->getMessage()}");
                } finally {
                    // Switch back to main database
                    $this->databaseSwitcher->switchToMain();
                }
            }

            // Paginate the merged results
            $products = $this->paginateCollection($results, $perPage, $request)
                ->appends(['query' => $query]);

            // Store query in session for search history
            $searchHistory = Session::get('drug_search_history', []);
            if (!in_array($query, $searchHistory)) {
                $searchHistory[] = $query;
                Session::put('drug_search_history', $searchHistory);
            }
        } else {
            $products = $this->paginateCollection($results, $perPage, $request);
        }

        return view('drugs.search', compact('products', 'query'));
    }

    public function details($product_id, $pharmacy_id)
    {
        // First, fetch the pharmacy to ensure it exists
        $pharmacy = Pharmacy::findOrFail($pharmacy_id);
    
        try {
            // Switch to the pharmacy database
            $this->databaseSwitcher->switchToPharmacy($pharmacy_id);
    
            // Query the product in the pharmacy database
            $product = Product::on('pharmacy_dynamic')
                ->with('unit')
                ->findOrFail($product_id);
        } catch (\Exception $e) {
            // Log the error for debugging
            \Log::error("Failed to fetch product {$product_id} in pharmacy {$pharmacy_id}: {$e->getMessage()}");
            throw $e; // Re-throw the exception to display the error to the user
        } finally {
            // Switch back to the main database
            $this->databaseSwitcher->switchToMain();
        }
    
        return view('drugs.pharmacy_details', compact('product', 'pharmacy'));
    }
    public function history(Request $request)
    {
        $searchHistory = Session::get('drug_search_history', []);
        return view('drugs.search_history', compact('searchHistory'));
    }

    public function clearHistory(Request $request)
    {
        Session::forget('drug_search_history');
        return redirect()->route('drug_search.history')->with('success', 'Search history cleared.');
    }

    /**
     * Paginate a collection manually.
     */
    protected function paginateCollection($items, $perPage, $request)
    {
        $page = $request->input('page', 1);
        $offset = ($page - 1) * $perPage;
        $total = $items->count();

        $paginatedItems = $items->slice($offset, $perPage);

        return new \Illuminate\Pagination\LengthAwarePaginator(
            $paginatedItems,
            $total,
            $perPage,
            $page,
            ['path' => $request->url(), 'query' => $request->query()]
        );
    }
}