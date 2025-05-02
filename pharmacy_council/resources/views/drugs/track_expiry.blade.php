@extends('layouts.app')

@section('content')
    <div class="container mx-auto px-4 py-6">
        <!-- Search Form -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <h2 class="text-2xl font-semibold text-gray-800 mb-4">Track Drug Expiry</h2>
            <form method="GET" action="{{ route('drug_search.track_expiry') }}" class="flex flex-col md:flex-row gap-4">
                <div class="flex-1">
                    <input 
                        type="text" 
                        name="query" 
                        id="search" 
                        value="{{ $query ?? '' }}"
                        placeholder="Enter drug name or code"
                        class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                    >
                </div>
                <button 
                    type="submit"
                    class="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors flex items-center justify-center"
                >
                    <i class="fas fa-search mr-2"></i> Search
                </button>
            </form>
        </div>

        <!-- Search Results or Prompt -->
        @if(!empty($query) && $products->isNotEmpty())
            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                <div class="p-6">
                    <h3 class="text-xl font-semibold text-gray-800 mb-4">Expiry Results for "{{ $query }}"</h3>
                    <p class="text-gray-600 mb-4">Showing {{ $products->firstItem() }} to {{ $products->lastItem() }} of {{ $products->total() }} results</p>
                </div>

                <div class="overflow-x-auto">
                    <table class="w-full border-collapse">
                        <thead>
                            <tr class="bg-gray-100 text-blue-700">
                                <th class="px-4 py-3 text-left">Drug Code</th>
                                <th class="px-4 py-3 text-left">Name</th>
                                <th class="px-4 py-3 text-left">Batch No</th>
                                <th class="px-4 py-3 text-left">Pharmacy</th>
                                <th class="px-4 py-3 text-left">Stock</th>
                                <th class="px-4 py-3 text-left">Expiry Date</th>
                                <th class="px-4 py-3 text-left">Status</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                            @foreach($products as $item)
                                @php
                                    $product = $item['product'];
                                    $pharmacy = $item['pharmacy'];
                                    $batchNo = $item['batch_no'];
                                    $remainingMonths = $item['remaining_months'];
                                    $remainingDaysAfterMonths = $item['remaining_days_after_months'];
                                    $flagColor = $item['flag_color'];
                                @endphp
                                <tr class="hover:bg-gray-50">
                                    <td class="px-4 py-3">{{ $product->code ?? 'N/A' }}</td>
                                    <td class="px-4 py-3 font-medium">{{ $product->name }}</td>
                                    <td class="px-4 py-3">{{ $batchNo ?? 'N/A' }}</td>
                                    <td class="px-4 py-3">{{ $pharmacy->name }}</td>
                                    <td class="px-4 py-3">{{ $item['quantity'] ?? 0 }}</td>
                                    <td class="px-4 py-3">
                                        @if($item['earliest_expired_date'])
                                            {{ \Carbon\Carbon::parse($item['earliest_expired_date'])->format('M d, Y') }}
                                        @else
                                            N/A
                                        @endif
                                    </td>
                                    <td class="px-4 py-3">
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium
                                            @if($flagColor === 'red') bg-red-100 text-red-800
                                            @elseif($flagColor === 'yellow') bg-yellow-100 text-yellow-800
                                            @elseif($flagColor === 'gray') bg-gray-100 text-gray-800
                                            @else bg-green-100 text-green-800 @endif">
                                            @if($remainingMonths === null && $remainingDaysAfterMonths === null)
                                                Expired
                                            @elseif($item['earliest_expired_date'] === null)
                                                No Expiry Data
                                            @else
                                                @if($remainingMonths == 0 && $remainingDaysAfterMonths <= 0)
                                                    Expired
                                                @elseif($remainingMonths == 0)
                                                    {{ $remainingDaysAfterMonths }} {{ $remainingDaysAfterMonths == 1 ? 'day' : 'days' }} remaining
                                                @elseif($remainingDaysAfterMonths > 0)
                                                    {{ $remainingMonths }} {{ $remainingMonths == 1 ? 'month' : 'months' }} {{ $remainingDaysAfterMonths }} {{ $remainingDaysAfterMonths == 1 ? 'day' : 'days' }} remaining
                                                @else
                                                    {{ $remainingMonths }} {{ $remainingMonths == 1 ? 'month' : 'months' }} remaining
                                                @endif
                                            @endif
                                        </span>
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <div class="px-6 py-4 border-t border-gray-200">
                    {{ $products->appends(['query' => $query])->links() }}
                </div>
            </div>
        @elseif(!empty($query))
            <div class="bg-white rounded-lg shadow-md p-6">
                <p class="text-gray-600 flex items-center">
                    <i class="fas fa-info-circle mr-2"></i> No drugs found for "{{ $query }}".
                </p>
            </div>
        @else
            <div class="bg-white rounded-lg shadow-md p-6">
                <p class="text-gray-600 flex items-center">
                    <i class="fas fa-info-circle mr-2"></i> Enter a drug name or code to track expiry dates.
                </p>
            </div>
        @endif
    </div>
@endsection

@section('scripts')
<script>
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