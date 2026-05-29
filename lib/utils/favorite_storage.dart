// lib/utils/favorite_storage.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitmart/models/product.dart';

class FavoriteStorage {
  static const String _keyPrefix = 'favorites_'; // Prefix dengan userID

  // Menyimpan daftar favorit berdasarkan userId
  static Future<void> saveFavorites(String userId, List<Product> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoritesJson = favorites.map((product) => jsonEncode({
      'id': product.id,
      'name': product.name,
      'category': product.category,
      'subCategory': product.subCategory,
      'emoji': product.emoji,
      'price': product.price,
      'description': product.description,
      'imageUrl': product.imageUrl,
    })).toList();

    await prefs.setStringList('$_keyPrefix$userId', favoritesJson);
  }

  // Memuat daftar favorit berdasarkan userId
  static Future<List<Product>> loadFavorites(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? favoritesJson = prefs.getStringList('$_keyPrefix$userId');

    if (favoritesJson == null) return [];

    return favoritesJson.map((jsonString) {
      final Map<String, dynamic> json = jsonDecode(jsonString);
      return Product(
        id: json['id'],
        name: json['name'],
        category: json['category'],
        subCategory: json['subCategory'],
        emoji: json['emoji'],
        price: (json['price'] as num).toDouble(),
        description: json['description'],
        imageUrl: json['imageUrl'],
      );
    }).toList();
  }
}