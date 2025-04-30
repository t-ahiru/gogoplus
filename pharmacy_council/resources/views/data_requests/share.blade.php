@extends('layouts.app')

@section('content')
    <div class="container mx-auto px-4 py-6">
        <div class="bg-white rounded-lg shadow-md p-6">
            <div class="flex justify-between items-center mb-6">
                <h1 class="text-2xl font-semibold text-gray-800">
                    Share Data Request #{{ $dataRequest->id }} ({{ $dataRequest->request_type }})
                </h1>
                <a href="{{ route('data_requests.index') }}" 
                   class="bg-gray-500 text-white px-4 py-2 rounded-lg hover:bg-gray-600 transition-colors">
                    Back to Data Requests
                </a>
            </div>

            @if (session('success'))
                <div class="alert alert-success mb-4">
                    {{ session('success') }}
                </div>
            @endif

            @if (session('error'))
                <div class="alert alert-danger mb-4">
                    {{ session('error') }}
                </div>
            @endif

            @if ($errors->any())
                <div class="alert alert-danger mb-4">
                    <ul>
                        @foreach ($errors->all() as $error)
                            <li>{{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <form action="{{ route('data_requests.share', $dataRequest->id) }}" method="POST">
                @csrf
                <div class="mb-4">
                    <label class="block text-gray-700 font-medium mb-2">Select Members to Share With:</label>
                    <div class="space-y-2">
                        @foreach ($users as $user)
                            <div class="flex items-center">
                                <input type="checkbox" 
                                       name="shared_with[]" 
                                       value="{{ $user->id }}" 
                                       id="user_{{ $user->id }}" 
                                       class="h-4 w-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500">
                                <label for="user_{{ $user->id }}" class="ml-2 text-gray-700">
                                    {{ $user->name }} ({{ $user->role->name ?? 'N/A' }})
                                </label>
                            </div>
                        @endforeach
                    </div>
                    @error('shared_with')
                        <span class="text-red-500 text-sm">{{ $message }}</span>
                    @enderror
                </div>

                <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition-colors">
                    Share Data Request
                </button>
            </form>
        </div>
    </div>
@endsection