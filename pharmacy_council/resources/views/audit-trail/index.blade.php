@extends('layouts.app')

@section('content')
<div class="container mx-auto px-4 py-6">
    <h1 class="text-2xl font-bold mb-6 text-gray-800">Audit Trail</h1>

    <!-- Audit Trail Table -->
    <div class="bg-white rounded-lg shadow-md p-6">
        <h2 class="text-xl font-semibold mb-4 text-gray-700">Audit Logs</h2>
        <div class="overflow-x-auto">
            <table class="min-w-full bg-white">
                <thead>
                    <tr class="bg-gray-100">
                        <th class="py-2 px-4 border">ID</th>
                        <th class="py-2 px-4 border">User</th>
                        <th class="py-2 px-4 border">Action</th>
                        <th class="py-2 px-4 border">Details</th>
                        <th class="py-2 px-4 border">Pharmacy</th>
                        <th class="py-2 px-4 border">Warehouse</th>
                        <th class="py-2 px-4 border">Created At</th>
                        <th class="py-2 px-4 border">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($auditLogsPaginated as $log)
                        <tr class="hover:bg-gray-50">
                            <td class="py-2 px-4 border">{{ $log->id }}</td>
                            <td class="py-2 px-4 border">{{ $log->user ? $log->user->name : 'System' }}</td>
                            <td class="py-2 px-4 border">{{ $log->action }}</td>
                            <td class="py-2 px-4 border">
                                @if($log->details)
                                    @php
                                        $details = json_decode($log->details, true);
                                        if ($log->action === 'updated' && isset($details['old'], $details['new'])) {
                                            $changes = [];
                                            foreach ($details['old'] as $key => $oldValue) {
                                                $newValue = $details['new'][$key];
                                                if ($oldValue !== $newValue) {
                                                    $changes[] = "$key: '$oldValue' → '$newValue'";
                                                }
                                            }
                                            echo $changes ? implode(', ', $changes) : 'No changes';
                                        } else {
                                            echo is_array($details) ? implode(', ', array_map(function($key, $value) {
                                                return "$key: $value";
                                            }, array_keys($details), $details)) : $log->details;
                                        }
                                    @endphp
                                @else
                                    N/A
                                @endif
                            </td>
                            <td class="py-2 px-4 border">{{ $log->pharmacy_name }}</td>
                            <td class="py-2 px-4 border">
                                @if($log->warehouse)
                                    {{ $log->warehouse->name }}
                                @else
                                    N/A
                                @endif
                            </td>
                            <td class="py-2 px-4 border">{{ $log->created_at->format('d/m/Y H:i:s') }}</td>
                            <td class="py-2 px-4 border flex space-x-2">
                                <a href="{{ route('audit-trail.edit', $log->id) }}" class="text-blue-600 hover:underline">Edit</a>
                                <button onclick="copyLog({{ $log->id }})" class="text-green-600 hover:underline">Copy</button>
                                <form action="{{ route('audit-trail.destroy', $log->id) }}" method="POST" onsubmit="return confirm('Are you sure you want to delete this log?');">
                                    @csrf
                                    @method('DELETE')
                                    <button type="submit" class="text-red-600 hover:underline">Delete</button>
                                </form>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="8" class="py-4 text-center text-gray-500">No audit logs found.</td>
                        </tr>
                    @endempty
                </tbody>
            </table>
            <div class="mt-4">
                {{ $auditLogsPaginated->links() }}
            </div>
        </div>
    </div>
</div>

<script>
    function copyLog(id) {
        alert('Copy functionality for log ID ' + id + ' is not implemented yet.');
    }
</script>
@endsection