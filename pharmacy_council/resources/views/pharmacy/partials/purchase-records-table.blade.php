<table class="table table-bordered">
    <thead>
        <tr>
            <th>Pharmacy</th>
            <th>Reference No</th>
            <th>Customer</th>
            <th>Warehouse ID</th>
            <th>Total Cost</th>
            <th>Created At</th>
        </tr>
    </thead>
    <tbody>
        @if ($purchaseRecords->isEmpty())
            <tr>
                <td colspan="6">No purchase records found.</td>
            </tr>
        @else
            @foreach ($purchaseRecords as $record)
                <tr>
                    <td>{{ $record->pharmacy_name }}</td>
                    <td>{{ $record->reference_no }}</td>
                    <td>{{ $record->customer->name ?? 'N/A' }}</td>
                    <td>{{ $record->warehouse_id }}</td>
                    <td>{{ $record->total_cost }}</td>
                    <td>{{ $record->created_at }}</td>
                </tr>
            @endforeach
        @endif
    </tbody>
</table>