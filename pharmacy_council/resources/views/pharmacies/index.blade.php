<!-- resources/views/pharmacies/index.blade.php -->
<x-app-layout>
    @slot('header')
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            Select Pharmacy to Track
        </h2>
    @endslot

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-blue-200 overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6">
                    <h3 class="text-lg font-medium text-gray-900 mb-4">Registered Pharmacies</h3>
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                        @foreach($pharmacies as $pharmacy)
                            <a href="{{ route('pharmacies.activities', $pharmacy) }}" 
                               class="block p-6 border border-blue-900 rounded-lg hover:bg-blue-100 transition-colors">
                                <div class="flex items-center">
                                    <div class="flex-shrink-0 h-10 w-10 rounded-full bg-blue-100 flex items-center justify-center">
                                        <i class="fas fa-pharmacy text-blue-600"></i>
                                    </div>
                                    <div class="ml-4">
                                        <h4 class="text-lg font-medium text-gray-900">{{ $pharmacy->name }}</h4>
                                        <p class="text-sm text-gray-500">{{ $pharmacy->location }}</p>
                                        <p class="text-xs text-gray-400 mt-1">Registered: {{ $pharmacy->created_at->format('M d, Y') }}</p>
                                    </div>
                                </div>
                            </a>
                        @endforeach
                    </div>
                    
                    @if($pharmacies->isEmpty())
                        <div class="text-center py-8">
                            <i class="fas fa-info-circle text-gray-400 text-4xl mb-3"></i>
                            <p class="text-gray-500">No pharmacies registered yet.</p>
                        </div>
                    @endif
                </div>
            </div>
        </div>
    </div>
</x-app-layout>