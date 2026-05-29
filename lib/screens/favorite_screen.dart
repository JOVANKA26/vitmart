import 'package:flutter/material.dart';
import 'package:vitmart/screens/detail.screen.dart';
import 'package:vitmart/screens/cart_screen.dart';
import 'package:vitmart/models/product.dart';
import 'package:vitmart/utils/favorite_manager.dart';
import 'package:vitmart/utils/cart_manager.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Semua', 'Makanan', 'Minuman', 'Obat-obatan'];
  final favManager = FavoriteManager();
  final cartManager = CartManager();

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

  void _confirmRemoveFavorite(Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus dari favorit'),
          content: Text('Apakah Anda yakin ingin menghapus ${product.name} dari daftar favorit?'),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Tidak')),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                favManager.removeFavorite(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${product.name} dihapus dari favorit'), duration: const Duration(seconds: 2)),
                );
              },
              child: const Text('Ya', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _addToCartAndGoToCart(Product product) {
    cartManager.addToCart(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.name} ditambahkan ke keranjang'), backgroundColor: const Color(0xFFE53E3E)),
    );
    Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
  }

  Future<void> _searchFavorites() async {
    final Product? selected = await showSearch<Product?>(
      context: context,
      delegate: FavoriteSearchDelegate(favorites: favManager.favorites.value),
    );
    if (selected != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(product: selected)));
    }
  }

  String _formatRupiah(double price) {
    final formatted = price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]}.');
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
          IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: _searchFavorites),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
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
                child: Text('${filtered.length} produk disimpan', style: const TextStyle(fontSize: 12, color: Colors.grey)),
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
                            onRemove: () => _confirmRemoveFavorite(product),
                            onAddToCart: () => _addToCartAndGoToCart(product),
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(product: product))),
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

// ========== SEARCH DELEGATE ==========
class FavoriteSearchDelegate extends SearchDelegate<Product?> {
  final List<Product> favorites;

  FavoriteSearchDelegate({required this.favorites});

  @override
  List<Widget>? buildActions(BuildContext context) => [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, null));

  @override
  Widget buildResults(BuildContext context) {
    final results = favorites.where((p) => p.name.toLowerCase().contains(query.toLowerCase())).toList();
    return _buildResultList(results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = favorites.where((p) => p.name.toLowerCase().contains(query.toLowerCase())).toList();
    return _buildResultList(suggestions);
  }

  Widget _buildResultList(List<Product> products) {
    if (products.isEmpty) return const Center(child: Text('Produk favorit tidak ditemukan'));
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final p = products[index];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              p.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Text(p.emoji, style: const TextStyle(fontSize: 30)),
            ),
          ),
          title: Text(p.name),
          subtitle: Text('${p.category} · ${p.subCategory}'),
          trailing: Text(_formatRupiah(p.price)),
          onTap: () => close(context, p),
        );
      },
    );
  }

  String _formatRupiah(double price) {
    final formatted = price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]}.');
    return 'Rp $formatted';
  }
}

// ========== WIDGET ITEM FAVORIT DENGAN GAMBAR ==========
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
            // GAMBAR PRODUK (bukan emoji)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                product.imageUrl,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 64,
                  height: 64,
                  color: const Color(0xFFF0F0F0),
                  child: Center(child: Text(product.emoji, style: const TextStyle(fontSize: 30))),
                ),
              ),
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

// ========== EMPTY STATE ==========
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
          Text('Belum ada produk favorit', style: TextStyle(fontSize: 15, color: Colors.grey.shade500)),
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