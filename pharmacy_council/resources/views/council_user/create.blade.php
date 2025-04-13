@extends('layouts.app')

@section('content')
    <div class="container mx-auto p-6">
        <h1 class="text-xl font-bold mb-4">Create New User</h1>

        @if ($errors->any())
            <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4" role="alert">
                <ul>
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        @endif

        <form action="{{ route('council_user.store') }}" method="POST" class="bg-white p-6 rounded shadow">
            @csrf
            <div class="mb-4">
                <label for="name" class="block text-gray-700 font-bold mb-2">Name</label>
                <input type="text" name="name" id="name" value="{{ old('name') }}"
                       class="w-full border rounded px-3 py-2 @error('name') border-red-500 @enderror"
                       required>
                @error('name')
                    <p class="text-red-500 text-sm mt-1">{{ $message }}</p>
                @enderror
            </div>

            <div class="mb-4">
                <label for="email" class="block text-gray-700 font-bold mb-2">Email</label>
                <input type="email" name="email" id="email" value="{{ old('email') }}"
                       class="w-full border rounded px-3 py-2 @error('email') border-red-500 @enderror"
                       required>
                @error('email')
                    <p class="text-red-500 text-sm mt-1">{{ $message }}</p>
                @enderror
            </div>

            <div class="mb-4">
                <label for="password" class="block text-gray-700 font-bold mb-2">Password</label>
                <input type="password" name="password" id="password"
                       class="w-full border rounded px-3 py-2 @error('password') border-red-500 @enderror"
                       required>
                @error('password')
                    <p class="text-red-500 text-sm mt-1">{{ $message }}</p>
                @enderror
            </div>

            <div class="mb-4">
                <label for="password_confirmation" class="block text-gray-700 font-bold mb-2">Confirm Password</label>
                <input type="password" name="password_confirmation" id="password_confirmation"
                       class="w-full border rounded px-3 py-2">
            </div>

            <div class="mb-4">
                <label for="role_id" class="block text-gray-700 font-bold mb-2">Role</label>
                <select name="role_id" id="role_id"
                        class="w-full border rounded px-3 py-2 @error('role_id') border-red-500 @enderror"
                        required>
                    <option value="1" {{ old('role_id') == 1 ? 'selected' : '' }}>admin</option>
                    <option value="2" {{ old('role_id') == 2 ? 'selected' : '' }}>member</option>
                </select>
                @error('role_id')
                    <p class="text-red-500 text-sm mt-1">{{ $message }}</p>
                @enderror
            </div>

            <div class="flex items-center">
                <button type="submit"
                        class="bg-blue-500 hover:bg-blue-700 text-blue font-bold py-2 px-4 rounded">
                    Create User
                </button>
                <a href="{{ route('council_user.index') }}"
                   class="ml-4 text-blue-500 hover:underline">
                    Cancel
                </a>
            </div>
        </form>
    </div>
@endsection