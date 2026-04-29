class Product {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  final String description;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.description,
    this.isFavorite = false,
  });
}