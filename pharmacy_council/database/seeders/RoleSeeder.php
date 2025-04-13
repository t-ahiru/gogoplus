<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Role;

class RoleSeeder extends Seeder
{
    public function run()
    {
    Role::create(['name' => 'admin', 'description' => 'Pharmacy Council Administrator']);
        Role::create(['name' => 'user', 'description' => 'Pharmacy User']);
    }
}