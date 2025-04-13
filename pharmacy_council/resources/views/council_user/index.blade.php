@extends('layouts.app')

@section('content')
    <div class="container mx-auto p-6">
        <h1 class="text-xl font-bold mb-4">Council Users</h1>

        <!-- Success Message -->
        @if (session('success'))
            <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-4" role="alert">
                {{ session('success') }}
            </div>
        @endif

        <!-- Create User Button -->
        <div class="mb-4">
            <a href="{{ route('council_user.create') }}"
               class="bg-blue-500 hover:bg-blue-700 text-blue font-bold py-2 px-4 rounded">
                Create New User
            </a>
        </div>

        <!-- Users Table -->
        <table class="table-auto w-full bg-white shadow rounded p-4">
            <thead>
                <tr class="bg-gray-200">
                    <th class="px-4 py-2">#</th>
                    <th class="px-4 py-2">Name</th>
                    <th class="px-4 py-2">Email</th>
                    <th class="px-4 py-2">Role</th>
                    <th class="px-4 py-2">Actions</th>
                </tr>
            </thead>
            <tbody>
                @forelse ($councilUsers as $index => $user)
                    <tr class="border-t">
                        <td class="px-4 py-2">{{ $index + 1 }}</td>
                        <td class="px-4 py-2">{{ $user->name }}</td>
                        <td class="px-4 py-2">{{ $user->email }}</td>
                        <td class="px-4 py-2">{{ $user->role_id == 1 ? 'Council User' : 'Admin' }}</td>
                        <td class="px-4 py-2">
                            <form action="{{ route('council_user.destroy', $user->id) }}" method="POST"
                                  onsubmit="return confirm('Are you sure you want to delete this user?');">
                                @csrf
                                @method('DELETE')
                                <button type="submit"
                                class="bg-blue-500 hover:bg-blue-700 text-blue font-bold py-2 px-4 rounded">
                                    Delete
                                </button>
                            </form>
                        </td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="5" class="px-4 py-2 text-center">No users found.</td>
                    </tr>
                @endforelse
            </tbody>
        </table>
    </div>
@endsection