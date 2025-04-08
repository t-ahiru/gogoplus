<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->string('phone')->nullable()->after('password');
            $table->unsignedBigInteger('role_id')->after('phone');
            $table->string('pharmacy_id')->nullable()->after('role_id');
            $table->boolean('is_active')->default(true)->after('pharmacy_id');
            $table->boolean('mfa_enabled')->default(false)->after('is_active');
            $table->string('mfa_secret')->nullable()->after('mfa_enabled');
            
            $table->foreign('role_id')->references('id')->on('roles')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            //
        });
    }
};
