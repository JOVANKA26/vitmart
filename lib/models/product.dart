// lib/models/product.dart (pastikan model Anda seperti ini)
class Product {
  final String id;
  final String name;
  final String category;
  final String subCategory;
  final String emoji;
  final double price;
  bool isFavorite;
  final String description;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.subCategory,
    required this.emoji,
    required this.price,
    this.isFavorite = false,
    this.description = '',
    this.imageUrl = '',
  });
}