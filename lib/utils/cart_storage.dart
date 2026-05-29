import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitmart/models/cart_item.dart';
import 'package:vitmart/models/product.dart';

class CartStorage {
  static const String _keyPrefix = 'cart_';

  static Future<void> saveCart(String userId, List<CartItem> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> cartJson = cartItems.map((item) {
      return {
        'product': {
          'id': item.product.id,
          'name': item.product.name,
          'price': item.product.price,
          'category': item.product.category,
          'subCategory': item.product.subCategory,
          'emoji': item.product.emoji,
          'description': item.product.description,
          'imageUrl': item.product.imageUrl,
        },
        'quantity': item.quantity,
      };
    }).toList();
    final String jsonString = jsonEncode(cartJson);
    await prefs.setString('$_keyPrefix$userId', jsonString);
  }

  static Future<List<CartItem>> loadCart(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('$_keyPrefix$userId');
    if (jsonString == null) return [];

    final List<dynamic> cartJson = jsonDecode(jsonString);
    return cartJson.map((itemJson) {
      final productJson = itemJson['product'];
      final product = Product(
        id: productJson['id'],
        name: productJson['name'],
        price: productJson['price'].toDouble(),
        category: productJson['category'],
        subCategory: productJson['subCategory'],
        emoji: productJson['emoji'],
        description: productJson['description'],
        imageUrl: productJson['imageUrl'],
      );
      return CartItem(product: product, quantity: itemJson['quantity']);
    }).toList();
  }
}