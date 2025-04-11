// resources/views/pharmacy-monitor/product-report.blade.php
@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row mb-4">
        <div class="col-md-12">
            <h2>Product Sales Report</h2>
            <div class="card">
                <div class="card-body">
                    <form method="GET" action="{{ route('pharmacy-monitor.product-report') }}">
                        <div class="row">
                            <div class="col-md-8">
                                <div class="form-group">
                                    <input type="text" class="form-control" name="search" 
                                        placeholder="Search by product name or code" value="{{ request('search') }}">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <button type="submit" class="btn btn-primary">Search</button>
                                @if(request()->has('search'))
                                <a href="{{ route('pharmacy-monitor.product-report') }}" class="btn btn-secondary ml-2">Reset</a>
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
                                <th>Code</th>
                                <th>Product Name</th>
                                <th>Brand</th>
                                <th>Category</th>
                                <th>Price</th>
                                <th>Stock</th>
                                <th>Total Sold</th>
                                <th>Total Revenue</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($products as $product)
                            <tr>
                                <td>{{ $product->code }}</td>
                                <td>{{ $product->name }}</td>
                                <td>{{ $product->brand->title ?? '-' }}</td>
                                <td>{{ $product->category->name ?? '-' }}</td>
                                <td>GHS {{ number_format($product->price, 2) }}</td>
                                <td>{{ $product->qty }}</td>
                                <td>{{ $product->total_sold ?? 0 }}</td>
                                <td>GHS {{ number_format($product->total_revenue ?? 0, 2) }}</td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                    
                    {{ $products->links() }}
                </div>
            </div>
        </div>
    </div>
</div>
@endsection