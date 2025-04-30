@extends('layouts.app')

@section('content')
    <div class="container mx-auto px-4 py-8">
        <!-- Search Form -->
        <div class="bg-gradient-to-r from-blue-50 to-indigo-50 rounded-xl shadow-lg p-6 mb-8 border border-blue-100">
            <h2 class="text-3xl font-bold text-gray-800 mb-2">Find Your Medication</h2>
            <p class="text-gray-600 mb-6">Search by product name or code to check availability and pricing</p>
            
            <form method="GET" action="{{ route('drug_search.search') }}" class="flex flex-col md:flex-row gap-4">
                <div class="flex-1 relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fas fa-search text-gray-400"></i>
                    </div>
                    <input 
                        type="text" 
                        name="query" 
                        id="search" 
                        value="{{ $query ?? '' }}"
                        placeholder="e.g. Ibuprofen, PAN12345"
                        class="w-full pl-10 p-4 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent shadow-sm"
                        autocomplete="off"
                    >
                </div>
                <button 
                    type="submit"
                    class="bg-gradient-to-r from-blue-600 to-indigo-600 text-white px-8 py-4 rounded-xl hover:from-blue-700 hover:to-indigo-700 transition-all duration-300 shadow-md flex items-center justify-center"
                >
                    <i class="fas fa-search mr-3"></i> Search
                </button>
            </form>
            
            <div class="mt-6">
                <a 
                    href="{{ route('drug_search.history') }}"
                    class="text-blue-600 hover:text-blue-800 transition-colors flex items-center text-sm font-medium"
                >
                    <i class="fas fa-history mr-2"></i> View your search history
                </a>
            </div>
        </div>

        <!-- Search Results -->
        @if(!empty($query) && $products->isNotEmpty())
            <div class="bg-white rounded-xl shadow-lg overflow-hidden border border-gray-100">
                <div class="p-6 bg-gradient-to-r from-blue-50 to-indigo-50">
                    <h3 class="text-2xl font-bold text-gray-800 mb-1">Results for "{{ $query }}"</h3>
                    <p class="text-gray-600">Found {{ $products->total() }} matching products</p>
                </div>

                <div class="overflow-x-auto">
                    <table class="w-full border-collapse">
                        <thead>
                            <tr class="bg-gray-50 text-gray-700">
                                <th class="px-6 py-4 text-left font-semibold">Product Code</th>
                                <th class="px-6 py-4 text-left font-semibold">Name</th>
                                <th class="px-6 py-4 text-left font-semibold">Availability</th>
                                <th class="px-6 py-4 text-left font-semibold">Total Stocks</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100">
                            @php
                                $groupedProducts = $products->groupBy(function ($item) {
                                    return $item['product']->id;
                                });
                            @endphp
                            @foreach($groupedProducts as $productId => $items)
                                @php
                                    $product = $items->first()['product'];
                                    $pharmacies = $items->pluck('pharmacy');
                                @endphp
                                
                                <tr class="bg-white even:bg-gray-50">
                                    <td class="px-6 py-4 font-mono text-blue-600">{{ $product->code ?? 'N/A' }}</td>
                                    <td class="px-6 py-4 font-medium text-gray-800">
                                        {{ $product->name }}
                                    </td>
                                    <td class="px-6 py-4">
                                        @if($pharmacies->isNotEmpty())
                                            <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-green-100 text-green-800">
                                                <i class="fas fa-check-circle mr-1.5"></i> {{ $pharmacies->count() }} locations
                                            </span>
                                        @else
                                            <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-red-100 text-red-800">
                                                <i class="fas fa-times-circle mr-1.5"></i> Not available
                                            </span>
                                        @endif
                                    </td>

                                    <td class="px-6 py-4">
                                        @if($pharmacies->isNotEmpty())
                                            @php
                                                $totalStock = $items->sum(function ($item) {
                                                    return $item['product']->qty;
                                                });
                                            @endphp
                                            <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-blue-100 text-blue-800">
                                                <i class="fas fa-check-circle mr-1.5"></i> {{ $totalStock }} in stock
                                            </span>
                                        @else
                                            <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-red-100 text-red-800">
                                                <i class="fas fa-times-circle mr-1.5"></i> No Stock
                                            </span>
                                        @endif
                                    </td>
                                </tr>
                                
                                @if($pharmacies->isNotEmpty())
                                <tr class="bg-blue-50">
                                    <td colspan="4" class="px-6 py-4">
                                        <div class="ml-8">
                                            <h4 class="font-medium text-gray-700 mb-3 flex items-center">
                                                <i class="fas fa-map-marker-alt mr-2 text-blue-500"></i>
                                                Available at these pharmacies:
                                            </h4>
                                            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                                                @foreach($pharmacies as $pharmacy)
                                                    @php
                                                        $productForPharmacy = $items->firstWhere('pharmacy.id', $pharmacy->id)['product'];
                                                    @endphp
                                                    <div class="bg-white border border-gray-200 rounded-lg p-4 hover:shadow-md transition-all">
                                                        <div>
                                                            <h5 class="font-bold text-gray-800 flex items-center justify-center">
                                                                <i class="fas fa-clinic-medical mr-2 text-blue-400"></i> 
                                                                {{ $pharmacy->name }}
                                                            </h5>
                                                            <div class="flex justify-between items-start">
                                                                <div>
                                                                    <p class="text-sm text-gray-600 mt-2 flex items-start">
                                                                        <i class="fas fa-map-pin mr-2 mt-0.5 text-gray-400"></i> 
                                                                        <a href="{{ route('drug_search.details', ['product_id' => $product->id, 'pharmacy_id' => $pharmacy->id]) }}" 
                                                                           class="text-blue-600 hover:text-blue-800">
                                                                            {{ $pharmacy->location }}
                                                                        </a>
                                                                    </p>
                                                                    <p class="text-sm text-gray-600 mt-2 flex items-start">
                                                                        <i class="fas fa-boxes mr-2 mt-0.5 text-gray-400"></i> 
                                                                        <span>
                                                                            Stock: {{ $productForPharmacy->qty }} 
                                                                            @if($productForPharmacy->unit)
                                                                                {{ $productForPharmacy->unit->unit_name }}
                                                                            @endif
                                                                        </span>
                                                                    </p>
                                                                    @if($productForPharmacy->updated_at)
                                                                        <p class="text-xs text-gray-500 bg-gray-100 px-2 py-1 rounded mt-2">
                                                                            Updated: {{ $productForPharmacy->updated_at->format('M d, Y H:i') }}
                                                                        </p>
                                                                    @endif
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="mt-3 pt-3 border-t border-gray-100 flex justify-end">
                                                            <a href="{{ route('drug_search.details', ['product_id' => $product->id, 'pharmacy_id' => $pharmacy->id]) }}" 
                                                               class="text-sm text-blue-600 hover:text-blue-800 font-medium">
                                                                View details <i class="fas fa-arrow-right ml-1"></i>
                                                            </a>
                                                        </div>
                                                    </div>
                                                @endforeach
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            @endif
                            @endforeach
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <div class="px-6 py-4 border-t border-gray-200 bg-gray-50">
                    {{ $products->appends(['query' => $query])->links() }}
                </div>
            </div>
        
        @elseif(!empty($query))
            <!-- No Results Found -->
            <div class="bg-white rounded-xl shadow-md p-8 text-center border border-gray-100">
                <div class="mx-auto w-24 h-24 bg-red-100 rounded-full flex items-center justify-center mb-4">
                    <i class="fas fa-exclamation-circle text-red-500 text-4xl"></i>
                </div>
                <h3 class="text-xl font-semibold text-gray-800 mb-2">No results found</h3>
                <p class="text-gray-600 mb-4">We couldn't find any products matching "{{ $query }}"</p>
                <button onclick="window.location.href='{{ route('drug_search.search') }}'" class="text-blue-600 hover:text-blue-800 font-medium">
                    <i class="fas fa-undo mr-2"></i> Try a new search
                </button>
            </div>
        
        @else
            <!-- Search Prompt -->
            <div class="bg-white rounded-xl shadow-md p-8 text-center border border-gray-100">
                <div class="mx-auto w-24 h-24 bg-blue-100 rounded-full flex items-center justify-center mb-4">
                    <i class="fas fa-search text-blue-500 text-3xl"></i>
                </div>
                <h3 class="text-xl font-semibold text-gray-800 mb-2">Ready to search</h3>
                <p class="text-gray-600 mb-4">Enter a product name or code in the search box above</p>
                <div class="text-sm text-gray-500">
                    <p class="mb-1"><i class="fas fa-lightbulb mr-2"></i> Tip: Try searching by brand or generic names</p>
                    <p><i class="fas fa-lightbulb mr-2"></i> You can also search by product codes</p>
                </div>
            </div>
        @endif
    </div>
@endsection

@section('scripts')
<script>
// Debounce search input
function debounce(func, wait) {
    let timeout;
    return function(...args) {
        clearTimeout(timeout);
        timeout = setTimeout(() => func.apply(this, args), wait);
    };
}

document.getElementById('search').addEventListener('input', debounce(function(e) {
    if (this.value.length > 2 || this.value.length === 0) {
        this.form.submit();
    }
}, 500));
</script>
@endsection