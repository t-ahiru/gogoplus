<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('data_request_shares', function (Blueprint $table) {
            $table->id();
            $table->foreignId('data_request_id')->constrained()->onDelete('cascade');
            $table->foreignId('shared_by')->constrained('users')->onDelete('cascade'); // Admin who shared
            $table->foreignId('shared_with')->constrained('users')->onDelete('cascade'); // User receiving the share
            $table->timestamp('shared_at')->useCurrent();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('data_request_shares');
    }
};