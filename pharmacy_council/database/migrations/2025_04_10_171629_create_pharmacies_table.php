<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
   // In the created migration file
public function up()
{
    Schema::create('pharmacies', function (Blueprint $table) {
        $table->id();
        $table->string('name');
        $table->string('license_number')->unique();
        $table->string('address');
        $table->string('location');
        $table->string('contact_phone');
        $table->string('contact_email');
        $table->timestamps();
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pharmacies');
    }
};
