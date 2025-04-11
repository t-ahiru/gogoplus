// resources/views/pharmacy-monitor/dashboard.blade.php
@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row mb-4">
        <div class="col-md-12">
            <h2>Pharmacy Sales Dashboard</h2>
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Today's Sales: GHS {{ number_format($todayTotal, 2) }}</h5>
                    <div class="row">
                        <div class="col-md-8">
                            <canvas id="dailySalesChart" height="150"></canvas>
                        </div>
                        <div class="col-md-4">
                            <h6>Top Selling Products Today</h6>
                            <ul class="list-group">
                                @foreach($topProducts as $product)
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    {{ $product->name }}
                                    <span class="badge badge-primary badge-pill">{{ $product->total_sold }}</span>
                                </li>
                                @endforeach
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h5>Today's Transactions</h5>
                </div>
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Reference</th>
                                <th>Customer</th>
                                <th>Items</th>
                                <th>Total</th>
                                <th>Status</th>
                                <th>Time</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($todaySales as $sale)
                            <tr>
                                <td>{{ $sale->reference_no }}</td>
                                <td>{{ $sale->customer->name ?? 'Walk-in' }}</td>
                                <td>{{ $sale->products->count() }}</td>
                                <td>GHS {{ number_format($sale->grand_total, 2) }}</td>
                                <td>
                                    @if($sale->sale_status == 1)
                                        <span class="badge badge-success">Completed</span>
                                    @else
                                        <span class="badge badge-warning">Pending</span>
                                    @endif
                                </td>
                                <td>{{ $sale->created_at->format('h:i A') }}</td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

@push('scripts')
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    const ctx = document.getElementById('dailySalesChart').getContext('2d');
    const dailySalesChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: {!! json_encode($monthlySales->pluck('date')) !!},
            datasets: [{
                label: 'Daily Sales (GHS)',
                data: {!! json_encode($monthlySales->pluck('total')) !!},
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>
@endpush
@endsection