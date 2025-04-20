@extends('layouts.app')

@section('content')
    <div class="container mx-auto px-4 py-6">
        <!-- Search Form -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <h2 class="text-2xl font-semibold text-gray-800 mb-4">Search Drugs</h2>
            <form method="GET" action="{{ route('drug_search.search') }}" class="flex flex-col md:flex-row gap-4">
                <div class="flex-1">
                    <input type="text" name="query" value="{{ $query ?? '' }}"
                           placeholder="Enter drug name, generic name, or code"
                           class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
                </div>
                <button type="submit"
                        class="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors flex items-center justify-center">
                    <i class="fas fa-search mr-2"></i> Search
                </button>
            </form>
            <div class="mt-4">
                <a href="{{ route('drug_search.history') }}"
                   class="text-blue-600 hover:text-blue-800 transition-colors flex items-center">
                    <i class="fas fa-history mr-2"></i> View Search History
                </a>
            </div>
        </div>

        <!-- Search Results or Prompt -->
        @if(!empty($query) && $drugs->isNotEmpty())
            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                <div class="p-6">
                    <h3 class="text-xl font-semibold text-gray-800 mb-4">Search Results for "{{ $query }}"</h3>
                    <p class="text-gray-600 mb-4">Showing {{ $drugs->firstItem() }} to {{ $drugs->lastItem() }} of {{ $drugs->total() }} results</p>
                </div>

                <div class="overflow-x-auto">
                    <table class="w-full border-collapse">
                        <thead>
                            <tr class="bg-gray-100 text-gray-700">
                                <th class="px-4 py-3 text-left">Drug Code</th>
                                <th class="px-4 py-3 text-left">Name</th>
                                <th class="px-4 py-3 text-left">Generic Name</th>
                                <th class="px-4 py-3 text-left">Availability Status</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                            @foreach($drugs as $drug)
                                <tr class="hover:bg-gray-50 group">
                                    <td class="px-4 py-3">{{ $drug->drug_code }}</td>
                                    <td class="px-4 py-3 font-medium">{{ $drug->name }}</td>
                                    <td class="px-4 py-3">{{ $drug->generic_name ?? 'N/A' }}</td>
                                    <td class="px-4 py-3">
                                        @if($drug->availability->isNotEmpty())
                                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                                Available in {{ $drug->availability->count() }} pharmacies
                                            </span>
                                        @else
                                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">
                                                Not available
                                            </span>
                                        @endif
                                    </td>
                                </tr>
                                <!-- Expanded row for pharmacy details -->
                                @if($drug->availability->isNotEmpty())
                                    <tr class="bg-gray-50">
                                        <td colspan="4" class="px-4 py-3">
                                            <div class="ml-8">
                                                <h4 class="font-medium text-gray-700 mb-2">Available in these pharmacies:</h4>
                                                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                                                    @foreach($drug->availability as $avail)
                                                        <div class="border border-gray-200 rounded-lg p-3 hover:bg-blue-50 transition-colors">
                                                            <div class="flex justify-between items-start">
                                                                <div>
                                                                    <h5 class="font-medium text-gray-800">Pharmacy_{{ $avail->pharmacy_id }}</h5>
                                                                    <p class="text-sm text-gray-600 mt-1">
                                                                        <span class="font-medium">{{ $avail->stock_quantity }}</span> units in stock
                                                                    </p>
                                                                </div>
                                                                @if($avail->last_updated)
                                                                    <span class="text-xs text-gray-500 bg-gray-100 px-2 py-1 rounded">
                                                                        Updated: {{ $avail->last_updated->format('M d, Y H:i') }}
                                                                    </span>
                                                                @endif
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
                <div class="px-6 py-4 border-t border-gray-200">
                    {{ $drugs->appends(['query' => $query])->links() }}
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
                    <i class="fas fa-info-circle mr-2"></i> Enter a drug name, generic name, or code to search.
                </p>
            </div>
        @endif
    </div>
@endsection