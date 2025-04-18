<!-- resources/views/drug_search/search_history.blade.php -->
@extends('layouts.app')

@section('content')
    <div class="container mx-auto px-4 py-6">
        <div class="bg-white rounded-lg shadow-md p-6">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-2xl font-semibold text-gray-800">Search History</h2>
                <a href="{{ route('drug_search.search') }}"
                   class="text-blue-600 hover:text-blue-800 transition-colors flex items-center">
                    <i class="fas fa-arrow-left mr-2"></i> Back to Search
                </a>
            </div>
            
            @if(!empty($searchHistory))
                <div class="space-y-3">
                    @foreach($searchHistory as $query)
                        <div class="p-3 border border-gray-200 rounded-lg hover:bg-gray-50 transition-colors">
                            <a href="{{ route('drug_search.search', ['query' => $query]) }}"
                               class="text-blue-600 hover:text-blue-800 transition-colors flex items-center">
                                <i class="fas fa-search mr-3 text-gray-400"></i>
                                <span class="text-lg">{{ $query }}</span>
                            </a>
                        </div>
                    @endforeach
                </div>
            @else
                <div class="text-center py-8">
                    <i class="fas fa-search text-gray-300 text-5xl mb-4"></i>
                    <p class="text-gray-600">No search history available.</p>
                </div>
            @endif

            @if(!empty($searchHistory))
    <form action="{{ route('drug_search.clear_history') }}" method="POST" class="mt-4">
        @csrf
        <button type="submit" class="bg-red-300 text-white px-4 py-2 rounded-lg hover:bg-red-500">
            Clear Search History
        </button>
    </form>
@endif
        </div>
    </div>
@endsection