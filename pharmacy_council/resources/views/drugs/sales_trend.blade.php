@extends('layouts.app')

@section('content')
<div class="container mx-auto px-4 py-8">
    <!-- Sales Trend Section -->
    <div class="bg-gradient-to-r from-blue-50 to-indigo-50 rounded-xl shadow-lg p-6 mb-8 border border-blue-100">
        <h1 class="text-3xl font-bold text-gray-800 mb-2">Drug Sales Trend Analysis</h1>
        <p class="text-gray-600 mb-6">Track sales performance by drug and pharmacy</p>
        
        <form id="salesForm" action="{{ route('sales.trend.data') }}" method="POST" class="space-y-4">
            @csrf
            <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                <div>
                    <label for="drugName" class="block text-sm font-medium text-gray-700 mb-1">Drug Name</label>
                    <input 
                        type="text" 
                        id="drugName" 
                        name="drugName" 
                        required
                        class="w-full p-3 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent shadow-sm"
                        placeholder="e.g. Ibuprofen, PAN12345"
                    >
                </div>
                
                <div>
                    <label for="pharmacy" class="block text-sm font-medium text-gray-700 mb-1">Pharmacy</label>
                    <select 
                        id="pharmacy" 
                        name="pharmacy" 
                        required
                        class="w-full p-3 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent shadow-sm"
                    >
                        <option value="">-- Select Pharmacy --</option>
                        @foreach($pharmacies as $pharmacy)
                            <option value="{{ $pharmacy->id }}">{{ $pharmacy->name }}</option>
                        @endforeach
                    </select>
                </div>
                
                <div>
                    <label for="month" class="block text-sm font-medium text-gray-700 mb-1">Month</label>
                    <select 
                        id="month" 
                        name="month" 
                        required
                        class="w-full p-3 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent shadow-sm"
                    >
                        <option value="">-- Select Month --</option>
                        @foreach([
                            '01' => 'January', '02' => 'February', '03' => 'March', 
                            '04' => 'April', '05' => 'May', '06' => 'June',
                            '07' => 'July', '08' => 'August', '09' => 'September',
                            '10' => 'October', '11' => 'November', '12' => 'December'
                        ] as $value => $label)
                            <option value="{{ $value }}">{{ $label }}</option>
                        @endforeach
                    </select>
                </div>
                
                <div>
                    <label for="year" class="block text-sm font-medium text-gray-700 mb-1">Year</label>
                    <select 
                        id="year" 
                        name="year" 
                        required
                        class="w-full p-3 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent shadow-sm"
                    >
                        <option value="">-- Select Year --</option>
                        @for($year = date('Y'); $year >= 2023; $year--)
                            <option value="{{ $year }}">{{ $year }}</option>
                        @endfor
                    </select>
                </div>
            </div>
            
            <button 
                type="submit"
                class="w-full md:w-auto bg-gradient-to-r from-blue-600 to-indigo-600 text-white px-8 py-3 rounded-xl hover:from-blue-700 hover:to-indigo-700 transition-all duration-300 shadow-md flex items-center justify-center mt-4"
            >
                <i class="fas fa-chart-line mr-3"></i> Generate Trend Report
            </button>
        </form>
    </div>

    <!-- Chart Container -->
    <div class="bg-white rounded-xl shadow-lg overflow-hidden border border-gray-100 p-6">
        <div id="chartError" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4"></div>
        <div class="chart-container" style="position: relative; height:400px; width:100%">
            <canvas id="salesChart"></canvas>
        </div>
    </div>
</div>
@endsection
@section('scripts')
<script type="module">
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('salesForm');
        
        form.addEventListener('submit', async function(e) {
            e.preventDefault();
            
            const response = await fetch(form.action, {
                method: 'POST',
                body: new FormData(form),
                headers: {
                    'Accept': 'application/json',
                    'X-CSRF-TOKEN': document.querySelector('input[name="_token"]').value
                }
            });
            
            const data = await response.json();
            
            // Update chart via Alpine component
            const chartComponent = document.querySelector('[x-data="salesChart"]');
            if (chartComponent) {
                chartComponent.__x.updateChart(data);
            }
        });
    });
</script>
@endsection