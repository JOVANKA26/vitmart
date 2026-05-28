import 'package:flutter/material.dart';
import '../models/product.dart';
import '../utils/favorite_manager.dart';
import 'favorite_screen.dart';

class DetailScreen extends StatelessWidget {
  final Product product;
  const DetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favManager = FavoriteManager();

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
              // Buka halaman favorit setelah menambah
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
            // Gambar (jika ada imageUrl, gunakan Image.asset, fallback ke emoji)
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
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${product.name} ditambahkan ke keranjang')),
                      ),
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