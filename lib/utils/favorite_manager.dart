// lib/utils/favorite_manager.dart
import 'package:flutter/material.dart';
import 'package:vitmart/utils/favorite_storage.dart';
import 'package:vitmart/models/product.dart';

class FavoriteManager {
  static final FavoriteManager _instance = FavoriteManager._internal();
  factory FavoriteManager() => _instance;
  FavoriteManager._internal();

  String? _currentUserId;
  final ValueNotifier<List<Product>> favorites = ValueNotifier([]);

  // Set user yang sedang login
  Future<void> setUser(String userId) async {
    if (_currentUserId == userId) return;
    _currentUserId = userId;
    await _loadFavorites();
  }

  // Muat favorit dari penyimpanan
  Future<void> _loadFavorites() async {
    if (_currentUserId == null) return;
    final loadedFavs = await FavoriteStorage.loadFavorites(_currentUserId!);
    favorites.value = loadedFavs;
  }

  // Simpan ke penyimpanan setiap ada perubahan
  Future<void> _persist() async {
    if (_currentUserId == null) return;
    await FavoriteStorage.saveFavorites(_currentUserId!, favorites.value);
  }

  // Tambah favorit
  Future<void> addFavorite(Product product) async {
    if (favorites.value.any((p) => p.id == product.id)) return;
    favorites.value = [...favorites.value, product];
    await _persist();
  }

  // Hapus favorit
  Future<void> removeFavorite(Product product) async {
    favorites.value = favorites.value.where((p) => p.id != product.id).toList();
    await _persist();
  }

  // Cek status favorit
  bool isFavorite(Product product) {
    return favorites.value.any((p) => p.id == product.id);
  }

  // Bersihkan data saat logout
  Future<void> clear() async {
    favorites.value = [];
    _currentUserId = null;
  }
}