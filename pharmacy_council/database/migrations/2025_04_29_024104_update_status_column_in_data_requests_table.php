<?php

  use Illuminate\Database\Migrations\Migration;
  use Illuminate\Database\Schema\Blueprint;
  use Illuminate\Support\Facades\Schema;

  return new class extends Migration
  {
      public function up(): void
      {
          Schema::table('data_requests', function (Blueprint $table) {
              $table->enum('status', ['pending', 'approved', 'rejected', 'failed', 'completed'])
                    ->default('pending')
                    ->change();
          });
      }

      public function down(): void
      {
          Schema::table('data_requests', function (Blueprint $table) {
              $table->enum('status', ['pending', 'approved', 'rejected', 'failed'])
                    ->default('pending')
                    ->change();
          });
      }
  };