class Product {
  final String id;
  final String title;
  final String description; // أضفنا هذا
  final String price;
  final String imageUrl;
  final String category;    // أضفنا هذا لتصفية الأقسام
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
    final images = json['images'];
    final imageUrl = (json['thumbnail'] ?? json['image'] ?? '').toString().isNotEmpty
        ? (json['thumbnail'] ?? json['image']).toString()
        : images is List && images.isNotEmpty
            ? images.first.toString()
            : '';

    return Product(
      id: json['id'].toString(),
      title: json['title']?.toString() ?? '',
      description: json['description'] ?? '', // التأكد من جلب الوصف
      price: json['price'].toString(),
      imageUrl: imageUrl,
      category: json['category']?.toString() ?? '', // جلب القسم من الـ API
    );
  }
}