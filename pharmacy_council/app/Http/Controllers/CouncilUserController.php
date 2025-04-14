<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class CouncilUserController extends Controller
{
    public function index()
{
    // Fetch paginated users with role_id 1, 2, 3, 4, or 5
    $councilUsers = User::whereIn('role_id', [1, 2, 3, 4, 5])
        ->orderBy('name') // Sort alphabetically by name
        ->paginate(15); // 15 users per page

    return view('council_user.index', compact('councilUsers'));
}

    public function create()
    {
        return view('council_user.create');
    }

    public function store(Request $request)
    {
    
        // Validate input
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8|confirmed',
            'role_id' => 'required|in:1,2',
        ]);

        // Create new user
        User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'role_id' => $request->role_id,
        ]);

        return redirect()->route('council_user.index')->with('success', 'User created successfully.');
    }

    public function destroy($id)
    {
        // Find and delete the user
        $user = User::whereIn('role_id', [1, 2])->findOrFail($id);
        $user->delete();

        return redirect()->route('council_user.index')->with('success', 'User deleted successfully.');
    }
}