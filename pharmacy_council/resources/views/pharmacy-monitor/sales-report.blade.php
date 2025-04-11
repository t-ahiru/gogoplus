// resources/views/pharmacy-monitor/sales-report.blade.php
@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row mb-4">
        <div class="col-md-12">
            <h2>Sales Report</h2>
            <div class="card">
                <div class="card-body">
                    <form method="GET" action="{{ route('pharmacy-monitor.sales-report') }}">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="from_date">From Date</label>
                                    <input type="date" class="form-control" id="from_date" name="from_date" 
                                        value="{{ request('from_date') }}">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="to_date">To Date</label>
                                    <input type="date" class="form-control" id="to_date" name="to_date" 
                                        value="{{ request('to_date') }}">
                                </div>
                            </div>
                            <div class="col-md-4 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary">Filter</button>
                                @if(request()->has('from_date'))
                                <a href="{{ route('pharmacy-monitor.sales-report') }}" class="btn btn-secondary ml-2">Reset</a>
                                @endif
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Reference</th>
                                <th>Customer</th>
                                <th>Items</th>
                                <th>Total</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($sales as $sale)
                            <tr>
                                <td>{{ $sale->created_at->format('Y-m-d') }}</td>
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
                                <td>
                                    <a href="#" class="btn btn-sm btn-info" data-toggle="modal" 
                                        data-target="#saleDetailsModal{{ $sale->id }}">
                                        Details
                                    </a>
                                </td>
                            </tr>
                            
                            <!-- Modal -->
                            <div class="modal fade" id="saleDetailsModal{{ $sale->id }}" tabindex="-1" role="dialog" 
                                aria-labelledby="saleDetailsModalLabel{{ $sale->id }}" aria-hidden="true">
                                <div class="modal-dialog modal-lg" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="saleDetailsModalLabel{{ $sale->id }}">
                                                Sale Details - {{ $sale->reference_no }}
                                            </h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="row mb-3">
                                                <div class="col-md-6">
                                                    <p><strong>Date:</strong> {{ $sale->created_at->format('Y-m-d H:i') }}</p>
                                                    <p><strong>Customer:</strong> {{ $sale->customer->name ?? 'Walk-in' }}</p>
                                                </div>
                                                <div class="col-md-6">
                                                    <p><strong>Warehouse:</strong> {{ $sale->warehouse->name }}</p>
                                                    <p><strong>Status:</strong> 
                                                        @if($sale->sale_status == 1)
                                                            <span class="badge badge-success">Completed</span>
                                                        @else
                                                            <span class="badge badge-warning">Pending</span>
                                                        @endif
                                                    </p>
                                                </div>
                                            </div>
                                            
                                            <table class="table table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th>Product</th>
                                                        <th>Qty</th>
                                                        <th>Price</th>
                                                        <th>Total</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    @foreach($sale->products as $product)
                                                    <tr>
                                                        <td>{{ $product->product->name }}</td>
                                                        <td>{{ $product->qty }}</td>
                                                        <td>GHS {{ number_format($product->net_unit_price, 2) }}</td>
                                                        <td>GHS {{ number_format($product->total, 2) }}</td>
                                                    </tr>
                                                    @endforeach
                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <th colspan="3" class="text-right">Subtotal:</th>
                                                        <th>GHS {{ number_format($sale->total_price, 2) }}</th>
                                                    </tr>
                                                    <tr>
                                                        <th colspan="3" class="text-right">Tax:</th>
                                                        <th>GHS {{ number_format($sale->total_tax, 2) }}</th>
                                                    </tr>
                                                    <tr>
                                                        <th colspan="3" class="text-right">Grand Total:</th>
                                                        <th>GHS {{ number_format($sale->grand_total, 2) }}</th>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            @endforeach
                        </tbody>
                    </table>
                    
                    {{ $sales->links() }}
                </div>
            </div>
        </div>
    </div>
</div>
@endsection