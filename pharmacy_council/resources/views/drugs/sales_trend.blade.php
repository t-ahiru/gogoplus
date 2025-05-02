@extends('layouts.app')

@section('content')
<div class="container mx-auto px-4 py-8">
    <!-- Sales Trend Section -->
    <div class="bg-gradient-to-r from-blue-50 to-indigo-50 rounded-xl shadow-lg p-6 mb-8 border border-blue-100">
        <h1 class="text-3xl font-bold text-gray-800 mb-2">Drug Sales Trend Analysis</h1>
        <p class="text-gray-600 mb-6">Track sales performance by drug and pharmacy</p>
        
        <form id="salesForm" action="{{ route('sales.trend.data') }}" method="POST" class="space-y-4">
            @csrf
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
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
                    <label for="timeFrame" class="block text-sm font-medium text-gray-700 mb-1">Time Frame</label>
                    <select 
                        id="timeFrame" 
                        name="timeFrame" 
                        required
                        class="w-full p-3 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent shadow-sm"
                    >
                        <option value="7">Last 7 Days</option>
                        <option value="30">Last 30 Days</option>
                        <option value="90">Last 90 Days</option>
                        <option value="365">Last 1 Year</option>
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
<!-- Using Chart.js from CDN with fallback -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Wait for DOM to be fully loaded
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('salesForm');
        const errorContainer = document.getElementById('chartError');
        
        form.addEventListener('submit', async function(event) {
            event.preventDefault();
            
            errorContainer.classList.add('hidden');
            
            // Show loading state
            const submitBtn = form.querySelector('button[type="submit"]');
            const originalBtnText = submitBtn.innerHTML;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin mr-2"></i> Loading...';
            submitBtn.disabled = true;
            
            try {
                const formData = new FormData(form);
                const response = await fetch(form.action, {
                    method: 'POST',
                    body: formData,
                    headers: {
                        'Accept': 'application/json',
                        'X-CSRF-TOKEN': document.querySelector('input[name="_token"]').value
                    }
                });
                
                if (!response.ok) {
                    const errorData = await response.json();
                    throw new Error(errorData.message || 'Failed to fetch data');
                }
                
                const data = await response.json();
                
                if (data.status === 'error') {
                    throw new Error(data.message);
                }
                
                renderChart(data, formData.get('drugName'), data.pharmacyName);
                
            } catch (error) {
                console.error('Error:', error);
                errorContainer.textContent = error.message;
                errorContainer.classList.remove('hidden');
            } finally {
                submitBtn.innerHTML = originalBtnText;
                submitBtn.disabled = false;
            }
        });
        
        function renderChart(data, drugName, pharmacyName) {
            const ctx = document.getElementById('salesChart').getContext('2d');
            
            // Destroy previous chart if exists
            if (window.salesChart) {
                window.salesChart.destroy();
            }
            
            // Find the maximum non-zero value for scaling
            const maxValue = Math.max(...data.quantities.filter(q => q > 0));
            
            window.salesChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: data.dates,
                    datasets: [{
                        label: `Sales of ${drugName} at ${pharmacyName}`,
                        data: data.quantities,
                        borderColor: 'rgba(79, 70, 229, 1)',
                        backgroundColor: 'rgba(79, 70, 229, 0.1)',
                        borderWidth: 2,
                        pointBackgroundColor: function(context) {
                            return context.raw > 0 ? 'rgba(79, 70, 229, 1)' : 'rgba(200, 200, 200, 0.5)';
                        },
                        pointRadius: function(context) {
                            return context.raw > 0 ? 5 : 2;
                        },
                        pointHoverRadius: 6,
                        fill: true,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'top',
                            labels: {
                                font: {
                                    size: 14
                                }
                            }
                        },
                        tooltip: {
                            mode: 'index',
                            intersect: false,
                            callbacks: {
                                label: function(context) {
                                    return `${context.dataset.label}: ${context.raw}`;
                                }
                            }
                        }
                    },
                    scales: {
                        x: {
                            title: {
                                display: true,
                                text: 'Date',
                                font: {
                                    weight: 'bold'
                                }
                            },
                            grid: {
                                display: false
                            }
                        },
                        y: {
                            title: {
                                display: true,
                                text: 'Quantity Sold',
                                font: {
                                    weight: 'bold'
                                }
                            },
                            beginAtZero: false,
                            suggestedMin: 0,
                            suggestedMax: maxValue > 0 ? maxValue * 1.2 : 100,
                            grid: {
                                color: 'rgba(0, 0, 0, 0.05)'
                            }
                        }
                    }
                }
            });
        }
    });
</script>
@endsection