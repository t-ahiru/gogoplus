<?php

namespace App\Http\Controllers;

use App\Models\Drug;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;

class DrugSearchController extends Controller
{

    public function search(Request $request)
    {
        $query = $request->input('query');
        $drugs = collect(); // Empty collection by default

        if (!empty($query)) {
            $drugs = Drug::with('availability')
                ->where('name', 'LIKE', "%{$query}%")
                ->orWhere('generic_name', 'LIKE', "%{$query}%")
                ->orWhere('drug_code', 'LIKE', "%{$query}%")
                ->where('is_active', 1)
                ->get();

            // Store query in session for search history
            $searchHistory = Session::get('drug_search_history', []);
            if (!in_array($query, $searchHistory)) {
                $searchHistory[] = $query;
                Session::put('drug_search_history', $searchHistory);
            }
        }

        return view('drugs.search', compact('drugs', 'query'));
    }

    public function history(Request $request)
    {
        $searchHistory = Session::get('drug_search_history', []);
        return view('drugs.search_history', compact('searchHistory'));
    }

        public function clearHistory(Request $request)
    {
    Session::forget('drug_search_history');
    return redirect()->route('drug_search.history')->with('success', 'Search history cleared.');
    }
}