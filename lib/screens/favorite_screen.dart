import 'package:flutter/material.dart';
import 'package:vitmart/screens/detail.screen.dart';
import '../models/product.dart';
import '../utils/favorite_manager.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Semua', 'Makanan', 'Minuman', 'Obat-obatan'];
  final favManager = FavoriteManager();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Product> get _filteredFavorites {
    final all = favManager.favorites.value;
    final tab = _tabs[_tabController.index];
    if (tab == 'Semua') return all;
    return all.where((p) => p.category == tab).toList();
  }

  // Menampilkan dialog konfirmasi sebelum menghapus
  void _confirmRemoveFavorite(Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus dari favorit'),
          content: Text('Apakah Anda yakin ingin menghapus ${product.name} dari daftar favorit?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Tidak jadi hapus
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // tutup dialog
                favManager.removeFavorite(product); // hapus produk
                // Optional: tampilkan snackbar notifikasi
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} dihapus dari favorit'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: const Text(
                'Ya',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _addToCart(Product product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} ditambahkan ke keranjang'),
        backgroundColor: const Color(0xFFE53E3E),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String _formatRupiah(double price) {
    final formatted = price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+$)'),
      (m) => '${m[1]}.',
    );
    return 'Rp $formatted';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text('Favorit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
          labelColor: const Color(0xFFE53E3E),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFFE53E3E),
          indicatorWeight: 2.5,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          unselectedLabelStyle: const TextStyle(fontSize: 13),
        ),
      ),
      body: ValueListenableBuilder<List<Product>>(
        valueListenable: favManager.favorites,
        builder: (context, favorites, _) {
          final filtered = _filteredFavorites;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 6),
                child: Text(
                  '${filtered.length} produk disimpan',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              Expanded(
                child: filtered.isEmpty
                    ? const _EmptyFavorite()
                    : ListView.separated(
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 1),
                        itemBuilder: (context, index) {
                          final product = filtered[index];
                          return _FavoriteItem(
                            product: product,
                            formatRupiah: _formatRupiah,
                            onRemove: () => _confirmRemoveFavorite(product), // ganti ke dialog
                            onAddToCart: () => _addToCart(product),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => DetailScreen(product: product)),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FavoriteItem extends StatelessWidget {
  final Product product;
  final String Function(double) formatRupiah;
  final VoidCallback onRemove;
  final VoidCallback onAddToCart;
  final VoidCallback onTap;

  const _FavoriteItem({
    required this.product,
    required this.formatRupiah,
    required this.onRemove,
    required this.onAddToCart,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(product.emoji, style: const TextStyle(fontSize: 30)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${product.category} · ${product.subCategory}',
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    formatRupiah(product.price),
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFFE53E3E)),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: onRemove,
                  child: const Icon(Icons.favorite, color: Color(0xFFE53E3E), size: 22),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: onAddToCart,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE53E3E),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.add_shopping_cart, color: Colors.white, size: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyFavorite extends StatelessWidget {
  const _EmptyFavorite();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.favorite_outline, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'Belum ada produk favorit',
            style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap ikon ❤️ pada produk untuk\nmenambahkannya ke favorit',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}