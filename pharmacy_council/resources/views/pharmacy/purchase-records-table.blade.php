<table class="table table-bordered">
    <thead>
        <tr>
            <th>Pharmacy</th>
            <th>Reference No</th>
            <th>Products</th>
            <th>Customer</th>
            <th>Warehouse ID</th>
            <th>Total Cost</th>
            <th>Created At</th>
        </tr>
    </thead>
    <tbody>
        @if (!$purchaseRecords || $purchaseRecords->isEmpty())
            <tr>
                <td colspan="7">No purchase records found.</td>
            </tr>
        @else
            @foreach ($purchaseRecords as $record)
                <tr>
                    <td>{{ $record->pharmacy_name ?? 'N/A' }}</td>
                    <td>{{ $record->reference_no ?? 'N/A' }}</td>
                    <td>
                        @if ($record->productPurchases && $record->productPurchases->isNotEmpty())
                            @foreach ($record->productPurchases as $productPurchase)
                                {{ $productPurchase->product->name ?? 'N/A' }} (Qty: {{ $productPurchase->qty ?? 0 }}, Total: {{ $productPurchase->total ?? 0 }})<br>
                            @endforeach
                        @else
                            No products associated.
                        @endif
                    </td>
                    <td>{{ $record->customer->name ?? 'N/A' }}</td>
                    <td>{{ $record->warehouse_id ?? 'N/A' }}</td>
                    <td>{{ $record->total_cost ?? '0.00' }}</td>
                    <td>{{ $record->created_at ?? 'N/A' }}</td>
                </tr>
            @endforeach
        @endif
    </tbody>
</table>