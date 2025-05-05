// app/Models/Pharmacy/Product.php
namespace App\Models\Pharmacy;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $connection = 'posintern';
    protected $table = 'products';
    
    protected $fillable = [
        'name', 'code', 'type', 'brand_id', 'category_id', 'price', 'qty'
    ];
    
    public function brand()
    {
        return $this->belongsTo(Brand::class);
    }
    
    public function category()
    {
        return $this->belongsTo(Category::class);
    }
}