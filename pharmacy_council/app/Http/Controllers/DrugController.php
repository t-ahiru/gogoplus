<?php

namespace App\Http\Controllers;

use App\Models\Drug;
use Illuminate\Http\Request;
use Illuminate\Support\Collection;

class DrugController extends Controller
{
    public function search(Request $request)
    {
        $query = $request->input('query');
        $drugs = collect(); // Initialize as an empty Collection

        if ($query) {
            $drugs = Drug::where('name', 'LIKE', "%{$query}%")
                ->select('name', 'code')
                ->get();
        }

        return view('drugs.search', compact('drugs', 'query'));
    }
}