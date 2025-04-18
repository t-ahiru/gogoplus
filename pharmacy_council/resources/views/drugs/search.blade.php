<!-- resources/views/drug_search/search.blade.php -->
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
            <div class="bg-white rounded-lg shadow-md p-6">
                <h3 class="text-xl font-semibold text-gray-800 mb-4">Search Results for "{{ $query }}"</h3>
                <div class="overflow-x-auto">
                    <table class="w-full border-collapse">
                        <thead>
                            <tr class="bg-gray-100 text-gray-700">
                                <th class="px-4 py-3 text-left">Drug Code</th>
                                <th class="px-4 py-3 text-left">Name</th>
                                <th class="px-4 py-3 text-left">Generic Name</th>
                                <th class="px-4 py-3 text-left">Available Pharmacies</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-200">
                            @foreach($drugs as $drug)
                                <tr class="hover:bg-gray-50">
                                    <td class="px-4 py-3">{{ $drug->drug_code }}</td>
                                    <td class="px-4 py-3">{{ $drug->name }}</td>
                                    <td class="px-4 py-3">{{ $drug->generic_name ?? 'N/A' }}</td>
                                    <td class="px-4 py-3">
                                        @if($drug->availability->isNotEmpty())
                                            <ul class="space-y-1">
                                                @foreach($drug->availability as $avail)
                                                    <li class="flex items-start">
                                                        <span class="inline-block bg-blue-100 text-blue-800 text-xs px-2 py-1 rounded-full mr-2">Pharmacy {{ $avail->pharmacy_id }}</span>
                                                        <span class="text-gray-700">{{ $avail->stock_quantity }} units</span>
                                                        @if($avail->last_updated)
                                                            <span class="text-gray-500 text-sm ml-2">(Last stocked: {{ $avail->last_updated->format('d/m/Y H:i') }})</span>
                                                        @endif
                                                    </li>
                                                @endforeach
                                            </ul>
                                        @else
                                            <span class="text-gray-500 italic">Not available in any pharmacy</span>
                                        @endif
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
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