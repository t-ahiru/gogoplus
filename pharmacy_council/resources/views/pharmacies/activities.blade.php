<!-- resources/views/pharmacies/activities.blade.php -->
<x-app-layout>
    @slot('header')
        <div class="flex items-center justify-between">
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Activities for {{ $pharmacy->name }}
            </h2>
            <a href="{{ route('pharmacies.index') }}" class="text-blue-600 hover:text-blue-800 text-sm">
                <i class="fas fa-arrow-left mr-1"></i> Back to pharmacies
            </a>
        </div>
    @endslot

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6">
                    <div class="mb-6">
                        <div class="flex items-center">
                            <div class="flex-shrink-0 h-12 w-12 rounded-full bg-blue-100 flex items-center justify-center">
                                <i class="fas fa-pharmacy text-blue-600 text-xl"></i>
                            </div>
                            <div class="ml-4">
                                <h3 class="text-lg font-medium text-gray-900">{{ $pharmacy->name }}</h3>
                                <p class="text-sm text-gray-500">{{ $pharmacy->address }}</p>
                                <p class="text-xs text-gray-400 mt-1">License: {{ $pharmacy->license_number }}</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="border-t border-gray-200 pt-6">
                        <h4 class="text-md font-medium text-gray-900 mb-4">Recent Activities</h4>
                        
                        <!-- Activity feed would go here -->
                        <div class="space-y-4">
                            <!-- Example activity item -->
                            <div class="flex items-start">
                                <div class="flex-shrink-0 h-8 w-8 rounded-full bg-green-100 flex items-center justify-center">
                                    <i class="fas fa-check text-green-600"></i>
                                </div>
                                <div class="ml-3">
                                    <p class="text-sm text-gray-700">
                                        <span class="font-medium">Inventory Update</span> - 10 new items added
                                    </p>
                                    <p class="text-xs text-gray-500">2 hours ago</p>
                                </div>
                            </div>
                            
                            <!-- Another example -->
                            <div class="flex items-start">
                                <div class="flex-shrink-0 h-8 w-8 rounded-full bg-blue-100 flex items-center justify-center">
                                    <i class="fas fa-shipping-fast text-blue-600"></i>
                                </div>
                                <div class="ml-3">
                                    <p class="text-sm text-gray-700">
                                        <span class="font-medium">Order Processed</span> - Order #12345 shipped
                                    </p>
                                    <p class="text-xs text-gray-500">1 day ago</p>
                                </div>
                            </div>
                        </div>
                        
                        <!-- You would replace the above with actual dynamic content from your database -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>