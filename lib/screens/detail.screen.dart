import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitmart/models/product.dart';
import 'package:vitmart/models/cart_item.dart'; // tambahkan
import 'package:vitmart/utils/favorite_manager.dart';
import 'package:vitmart/utils/cart_manager.dart';
import 'package:vitmart/screens/favorite_screen.dart';
import 'package:vitmart/screens/cart_screen.dart';
import 'payment_screen.dart';

// ========== DetailScreen ==========
class DetailScreen extends StatelessWidget {
  final Product product;
  const DetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favManager = FavoriteManager();
    final cartManager = CartManager();

    void _showAddToCartDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Pilihan Belanja'),
            content: Text('${product.name} akan ditambahkan ke keranjang.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  cartManager.addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${product.name} ditambahkan ke keranjang')),
                  );
                  // Gunakan subtotal dari CartManager yang sudah menghitung quantity
                  double subtotal = cartManager.subtotal;
                  const int pajak = 2500;
                  int total = (subtotal + pajak).toInt();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentScreen(total: total, method: "Transfer Bank"),
                    ),
                  );
                },
                child: const Text('Langsung Checkout'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  cartManager.addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${product.name} ditambahkan ke keranjang')),
                  );
                },
                child: const Text('Tambah ke Keranjang'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              favManager.addFavorite(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${product.name} ditambahkan ke favorit')),
              );
              // Hapus Navigator.pop(context) agar tidak menutup halaman detail
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoriteScreen()),
              );
            },
            tooltip: 'Tambah ke Favorit',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              color: Colors.grey.shade200,
              child: product.imageUrl.isNotEmpty
                  ? Image.asset(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildEmojiPlaceholder(),
                    )
                  : _buildEmojiPlaceholder(),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(_formatRupiah(product.price), style: const TextStyle(fontSize: 24, color: Colors.green)),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(color: Colors.blue.shade100, borderRadius: BorderRadius.circular(20)),
                    child: Text(product.category, style: const TextStyle(fontSize: 14)),
                  ),
                  const SizedBox(height: 24),
                  const Text('Deskripsi Produk', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(product.description.isNotEmpty ? product.description : 'Tidak ada deskripsi', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _showAddToCartDialog,
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text('Beli Sekarang'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmojiPlaceholder() => Center(
        child: Text(product.emoji, style: const TextStyle(fontSize: 80)),
      );

  String _formatRupiah(double price) {
    final formatted = price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+$)'),
      (m) => '${m[1]}.',
    );
    return 'Rp $formatted';
  }
}