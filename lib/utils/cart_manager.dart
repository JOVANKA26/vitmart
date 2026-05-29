import 'package:flutter/material.dart';
import 'package:vitmart/models/cart_item.dart';
import 'package:vitmart/models/product.dart';
import 'cart_storage.dart';

class CartManager {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  String? _currentUserId;
  final ValueNotifier<List<CartItem>> cartItems = ValueNotifier([]);

  Future<void> setUser(String userId) async {
    if (_currentUserId == userId) return;
    _currentUserId = userId;
    await _loadCart();
  }

  Future<void> _loadCart() async {
    if (_currentUserId == null) return;
    final loaded = await CartStorage.loadCart(_currentUserId!);
    cartItems.value = loaded;
  }

  Future<void> _persist() async {
    if (_currentUserId == null) return;
    await CartStorage.saveCart(_currentUserId!, cartItems.value);
  }

  void addToCart(Product product) {
    final existingIndex = cartItems.value.indexWhere((item) => item.product.id == product.id);
    if (existingIndex != -1) {
      final updated = List<CartItem>.from(cartItems.value);
      updated[existingIndex].quantity++;
      cartItems.value = updated;
    } else {
      cartItems.value = [...cartItems.value, CartItem(product: product)];
    }
    _persist();
  }

  void removeOneFromCart(Product product) {
    final existingIndex = cartItems.value.indexWhere((item) => item.product.id == product.id);
    if (existingIndex != -1) {
      final updated = List<CartItem>.from(cartItems.value);
      if (updated[existingIndex].quantity > 1) {
        updated[existingIndex].quantity--;
      } else {
        updated.removeAt(existingIndex);
      }
      cartItems.value = updated;
      _persist();
    }
  }

  void removeItemCompletely(Product product) {
    cartItems.value = cartItems.value.where((item) => item.product.id != product.id).toList();
    _persist();
  }

  void clearCart() {
    cartItems.value = [];
    _persist();
  }

  int get totalItems => cartItems.value.fold(0, (sum, item) => sum + item.quantity);
  double get subtotal => cartItems.value.fold(0, (sum, item) => sum + item.totalPrice);
}