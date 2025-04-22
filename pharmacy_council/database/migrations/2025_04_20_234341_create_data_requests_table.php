<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDataRequestsTable extends Migration
{
    public function up()
    {
        Schema::create('data_requests', function (Blueprint $table) {
            $table->id();
            $table->foreignId('pharmacy_id')->constrained()->onDelete('cascade');
            $table->string('request_type'); // e.g., sales_data, inventory
            $table->text('details')->nullable(); // JSON or text for request specifics
            $table->string('status')->default('pending'); // pending, completed, failed
            $table->text('response_data')->nullable(); // Store API response
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('data_requests');
    }
}