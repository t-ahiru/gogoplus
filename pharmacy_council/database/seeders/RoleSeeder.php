<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Role;

class RoleSeeder extends Seeder
{
    public function run()
    {
    Role::create(['name' => 'council_admin', 'description' => 'Pharmacy Council Administrator']);
        Role::create(['name' => 'pharmacy_admin', 'description' => 'Pharmacy Administrator']);
    }
}
