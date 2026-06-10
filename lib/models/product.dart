class Product {
  final String id;
  final String title;
  final String description; 
  final String price;
  final String imageUrl;
  final String category;    
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // معالجة مرنة للصور لضمان عدم حدوث خطأ إذا لم تتوفر الصورة
    final images = json['images'];
    final imageUrl = (json['thumbnail'] ?? json['image'] ?? '').toString().isNotEmpty
        ? (json['thumbnail'] ?? json['image']).toString()
        : images is List && images.isNotEmpty
            ? images.first.toString()
            : '';

    return Product(
      // نضمن تحويل كل شيء لنصوص بأمان مع وضع قيم افتراضية في حال كانت null
      id: (json['id'] ?? '').toString(),
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '', // أمان إضافي للوصف
      price: (json['price'] ?? '0').toString(), // إذا كان السعر فارغاً يضع '0' لمنع كراش التطبيق
      imageUrl: imageUrl,
      category: json['category']?.toString() ?? '', 
    );
  }
}