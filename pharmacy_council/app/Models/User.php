<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, Notifiable;

    protected $fillable = [
        'name', 'email', 'password', 'phone', 'role_id', 'pharmacy_id', 'is_active', 'mfa_enabled', 'mfa_secret',
    ];

    protected $hidden = [
        'password', 'remember_token', 'mfa_secret',
    ];

    public function role()
    {
        return $this->belongsTo(Role::class);
    }

    public function isCouncilAdmin()
    {
        return $this->role->name === 'council_admin';
    }
}