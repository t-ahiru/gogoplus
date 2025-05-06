<?php

namespace App\Http\Controllers;

use App\Models\Pharmacy;
use App\Models\Product;
use App\Services\DatabaseSwitcher;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Carbon;


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

    public function trackExpiry(Request $request)
    {
        $query = $request->input('query');
        $perPage = 10;
        $results = collect();
    
        if (!empty($query)) {
            \Log::info("Searching for query: {$query}");
            $pharmacies = Pharmacy::select('id', 'name', 'location')->get();
    
            foreach ($pharmacies as $pharmacy) {
                try {
                    \Log::info("Switching to pharmacy: {$pharmacy->id}");
                    $this->databaseSwitcher->switchToPharmacy($pharmacy->id);
    
                    \Log::info("Current database: " . \DB::connection('pharmacy_dynamic')->getDatabaseName());
    
                    // Fetch products and their batches without aggregating
                    $products = Product::on('pharmacy_dynamic')
                        ->select('products.*')
                        ->where('is_active', 1)
                        ->where(function ($q) use ($query) {
                            $q->where('name', 'LIKE', "%{$query}%")
                              ->orWhere('code', 'LIKE', "%{$query}%");
                        })
                        ->with(['unit', 'batches' => function ($query) {
                            $query->select('product_batches.*');
                        }])
                        ->get();
    
                    \Log::info("Found {$products->count()} products in pharmacy {$pharmacy->id} for query: {$query}", [
                        'products' => $products->toArray()
                    ]);
    
                    // Process each batch individually
                    $batchResults = collect();
                    foreach ($products as $product) {
                        if ($product->batches->isEmpty()) {
                            // If no batches, add a placeholder entry
                            $batchResults->push([
                                'product' => $product,
                                'pharmacy' => $pharmacy,
                                'batch_no' => null,
                                'earliest_expired_date' => null,
                                'quantity' => 0,
                                'remaining_months' => null,
                                'remaining_days_after_months' => null,
                                'flag_color' => 'gray',
                            ]);
                            continue;
                        }
    
                        foreach ($product->batches as $batch) {
                            \Log::info("Processing batch {$batch->batch_no} for product {$product->id} in pharmacy {$pharmacy->id}", [
                                'batch_id' => $batch->id,
                                'product_id' => $product->id,
                                'name' => $product->name,
                                'earliest_expired_date' => $batch->expired_date,
                                'quantity' => $batch->qty
                            ]);
    
                            $remainingMonths = null;
                            $remainingDaysAfterMonths = null;
                            $flagColor = 'gray';
    
                            if ($batch->expired_date) {
                                try {
                                    $expiryDate = Carbon::parse($batch->expired_date);
                                    $now = Carbon::now();
    
                                    \Log::info("Expiry check for batch {$batch->batch_no} of product {$product->id}", [
                                        'earliest_expired_date' => $batch->expired_date,
                                        'parsed_expiry' => $expiryDate->toDateTimeString(),
                                        'now' => $now->toDateTimeString(),
                                        'is_past' => $expiryDate->lte($now)
                                    ]);
    
                                    if ($expiryDate->lte($now)) {
                                        \Log::info("Batch {$batch->batch_no} of product {$product->id} in pharmacy {$pharmacy->id} is expired", [
                                            'expiry_date' => $batch->expired_date
                                        ]);
                                        $flagColor = 'red';
                                        $remainingMonths = null;
                                        $remainingDaysAfterMonths = null;
                                    } else {
                                        $remainingMonths = (int)$now->diffInMonths($expiryDate, false);
                                        $tempDate = $now->copy()->addMonths($remainingMonths);
                                        $remainingDaysAfterMonths = (int)$tempDate->diffInDays($expiryDate, false);
    
                                        if ($remainingDaysAfterMonths < 0) {
                                            \Log::warning("Negative days detected for batch {$batch->batch_no} of product {$product->id}, marking as expired", [
                                                'remaining_days' => $remainingDaysAfterMonths
                                            ]);
                                            $remainingMonths = null;
                                            $remainingDaysAfterMonths = null;
                                            $flagColor = 'red';
                                        } else {
                                            if ($remainingMonths <= 3) {
                                                $flagColor = 'red';
                                            } elseif ($remainingMonths <= 6) {
                                                $flagColor = 'yellow';
                                            } else {
                                                $flagColor = 'green';
                                            }
                                        }
                                    }
                                } catch (\Exception $e) {
                                    \Log::error("Failed to parse expiry date for batch {$batch->batch_no} of product {$product->id}: {$e->getMessage()}");
                                    $flagColor = 'gray';
                                    $remainingMonths = null;
                                    $remainingDaysAfterMonths = null;
                                }
                            }
    
                            $batchResults->push([
                                'product' => $product,
                                'pharmacy' => $pharmacy,
                                'batch_no' => $batch->batch_no,
                                'earliest_expired_date' => $batch->expired_date,
                                'quantity' => $batch->qty,
                                'remaining_months' => $remainingMonths,
                                'remaining_days_after_months' => $remainingDaysAfterMonths,
                                'flag_color' => $flagColor,
                            ]);
                        }
                    }
    
                    $results = $results->merge($batchResults);
                } catch (\Exception $e) {
                    \Log::error("Failed to query expiry dates for pharmacy {$pharmacy->id}: {$e->getMessage()}");
                } finally {
                    $this->databaseSwitcher->switchToMain();
                }
            }
    
            $products = $this->paginateCollection($results, $perPage, $request)
                ->appends(['query' => $query]);
    
            $searchHistory = Session::get('drug_search_history', []);
            if (!in_array($query, $searchHistory)) {
                $searchHistory[] = $query;
                Session::put('drug_search_history', $searchHistory);
            }
        } else {
            $products = $this->paginateCollection($results, $perPage, $request);
        }
    
        return view('drugs.track_expiry', compact('products', 'query'));
    }
}