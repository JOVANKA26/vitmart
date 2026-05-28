import 'package:flutter/material.dart';
import '../models/product.dart';

class FavoriteManager {
  static final FavoriteManager _instance = FavoriteManager._internal();
  factory FavoriteManager() => _instance;
  FavoriteManager._internal();

  final ValueNotifier<List<Product>> favorites = ValueNotifier([]);

  void addFavorite(Product product) {
    if (!favorites.value.any((p) => p.id == product.id)) {
      favorites.value = [...favorites.value, product];
    }
  }

  void removeFavorite(Product product) {
    favorites.value = favorites.value.where((p) => p.id != product.id).toList();
  }

  bool isFavorite(Product product) {
    return favorites.value.any((p) => p.id == product.id);
  }
}