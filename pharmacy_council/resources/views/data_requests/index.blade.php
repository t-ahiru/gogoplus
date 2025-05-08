@extends('layouts.app')

@section('content')
    <div class="container mx-auto px-4 py-6">
        <div class="bg-white rounded-lg shadow-md p-6">
            <div class="flex justify-between items-center mb-6">
                <h1 class="text-2xl font-semibold text-gray-800">Data Requests</h1>
                @if (auth()->user()->role_id === 1)
                    <a href="{{ route('data_requests.create') }}" 
                       class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition-colors flex items-center">
                        <i class="fas fa-plus mr-2"></i> New Request
                    </a>
                @endif
            </div>

            <div class="overflow-x-auto">
                <table class="w-full border-collapse">
                    <thead>
                        <tr class="bg-gray-100 text-gray-700">
                            <th class="px-4 py-3 text-left">Pharmacy</th>
                            <th class="px-4 py-3 text-left">Request Type</th>
                            <th class="px-4 py-3 text-left">Status</th>
                            <th class="px-4 py-3 text-left">Response</th>
                            <th class="px-4 py-3 text-left">File</th>
                            <th class="px-4 py-3 text-left">Created At</th>
                            <th class="px-4 py-3 text-left">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200">
                        @forelse ($dataRequests as $request)
                            <tr class="hover:bg-gray-50">
                                <td class="px-4 py-3">{{ $request->pharmacy ? $request->pharmacy->name : 'Unknown Pharmacy' }}</td>
                                <td class="px-4 py-3">{{ $request->request_type }}</td>
                                <td class="px-4 py-3">
                                    @if($request->status === 'pending')
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">
                                            Pending
                                        </span>
                                    @elseif($request->status === 'approved')
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                            Approved
                                        </span>
                                    @elseif($request->status === 'rejected')
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">
                                            Rejected
                                        </span>
                                    @elseif($request->status === 'failed')
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-800">
                                            Failed
                                        </span>
                                    @elseif($request->status === 'completed')
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                                            Completed
                                        </span>
                                    @else
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-800">
                                            Unknown
                                        </span>
                                    @endif
                                </td>
                                <td class="px-4 py-3">{{ $request->response_data ?? 'N/A' }}</td>
                                <td class="px-4 py-3">
                                    @if ($request->file_path)
                                        <a href="{{ Storage::url($request->file_path) }}" target="_blank" class="text-blue-600 hover:underline">View File</a>
                                    @else
                                        N/A
                                    @endif
                                </td>
                                <td class="px-4 py-3">{{ $request->created_at->format('M d, Y H:i') }}</td>
                                <td class="px-4 py-3">
                                    @if (auth()->user()->role_id === 1 && $request->status === 'approved')
                                        <a href="{{ route('data_requests.share.form', $request->id) }}" 
                                           class="bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600 transition-colors">
                                            Share
                                        </a>
                                    @endif
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="7" class="px-4 py-3 text-center text-gray-500">No data requests found.</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>

            @if($dataRequests->hasPages())
                <div class="mt-6">
                    {{ $dataRequests->links() }}
                </div>
            @endif
        </div>
    </div>
@endsection