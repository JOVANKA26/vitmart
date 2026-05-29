import 'package:flutter/material.dart';
import 'package:vitmart/models/product.dart';
import 'package:vitmart/utils/cart_manager.dart';
import 'package:vitmart/widgets/search_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = "";

  final List<Product> products = [
    Product(
      id: '1',
      name: 'Chitato',
      price: 10000,
      category: 'Makanan',
      subCategory: 'Snack',
      emoji: '🍟',
      description: 'Keripik kentang premium.',
      imageUrl: 'images/Chitato.jpg',
    ),
    Product(
      id: '2',
      name: 'Big Babol',
      price: 2500,
      category: 'Makanan',
      subCategory: 'Permen',
      emoji: '🍬',
      description: 'Permen susu kenyal.',
      imageUrl: 'images/Bigbabol.jpg',
    ),
    Product(
      id: '3',
      name: 'Kacang Garuda',
      price: 7000,
      category: 'Makanan',
      subCategory: 'Snack',
      emoji: '🥜',
      description: 'Kacang gurih.',
      imageUrl: 'images/Kacang.jpg',
    ),
    Product(
      id: '4',
      name: 'Khong Guan',
      price: 55000,
      category: 'Makanan',
      subCategory: 'Biskuit',
      emoji: '🍪',
      description: 'Biskuit asin.',
      imageUrl: 'images/Khongguan.jpg',
    ),
    Product(
      id: '5',
      name: 'Cocacola',
      price: 6000,
      category: 'Minuman',
      subCategory: 'Soda',
      emoji: '🥤',
      description: 'Minuman bersoda.',
      imageUrl: 'images/Cocacola.jpg',
    ),
    Product(
      id: '6',
      name: 'Fanta',
      price: 11000,
      category: 'Minuman',
      subCategory: 'Soda',
      emoji: '🍊',
      description: 'Minuman rasa jeruk.',
      imageUrl: 'images/Fanta.jpg',
    ),
    Product(
      id: '7',
      name: 'Golda',
      price: 5000,
      category: 'Minuman',
      subCategory: 'Susu',
      emoji: '🥛',
      description: 'Susu kotak.',
      imageUrl: 'images/Golda.png',
    ),
    Product(
      id: '8',
      name: 'Le Minerale',
      price: 8000,
      category: 'Minuman',
      subCategory: 'Air Mineral',
      emoji: '💧',
      description: 'Air mineral.',
      imageUrl: 'images/Minerale.webp',
    ),
    Product(
      id: '9',
      name: 'Mylanta',
      price: 5000,
      category: 'Suplemen',
      subCategory: 'Obat Maag',
      emoji: '💊',
      description: 'Obat maag.',
      imageUrl: 'images/Mylanta.jpg',
    ),
    Product(
      id: '10',
      name: 'OBH Combi',
      price: 18000,
      category: 'Suplemen',
      subCategory: 'Obat Batuk',
      emoji: '🌿',
      description: 'Obat batuk.',
      imageUrl: 'images/Obhcombi.webp',
    ),
    Product(
      id: '11',
      name: 'Tolak Angin',
      price: 2500,
      category: 'Suplemen',
      subCategory: 'Herbal',
      emoji: '🌱',
      description: 'Herbal masuk angin.',
      imageUrl: 'images/Tolakangin.jpg',
    ),
    Product(
      id: '12',
      name: 'Oskadon',
      price: 12500,
      category: 'Suplemen',
      subCategory: 'Obat',
      emoji: '💊',
      description: 'Parasetamol.',
      imageUrl: 'images/Oskadon.jpg',
    ),
    Product(
      id: '13',
      name: 'Hot Wheels',
      price: 30000,
      category: 'Mainan',
      subCategory: 'Mobil',
      emoji: '🚗',
      description: 'Mobil die-cast.',
      imageUrl: 'images/Hotwheels.webp',
    ),
    Product(
      id: '14',
      name: 'Uno',
      price: 15000,
      category: 'Mainan',
      subCategory: 'Kartu',
      emoji: '🃏',
      description: 'Kartu permainan.',
      imageUrl: 'images/Uno.webp',
    ),
    Product(
      id: '15',
      name: 'Kartu Pokemon',
      price: 25000,
      category: 'Mainan',
      subCategory: 'Kartu',
      emoji: '⚡',
      description: 'Kartu koleksi.',
      imageUrl: 'images/Pokemon.webp',
    ),
    Product(
      id: '16',
      name: 'Kartu Boboiboy',
      price: 20000,
      category: 'Mainan',
      subCategory: 'Kartu',
      emoji: '🌀',
      description: 'Kartu Boboiboy.',
      imageUrl: 'images/Boboiboy.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((product) {
      return product.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: SearchBarWidget(
                showBackButton: true,
                showMessageIcon: false,
                onBackTap: () {
                  Navigator.pop(context);
                },
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            Expanded(
              child: filteredProducts.isEmpty
                  ? const Center(
                      child: Text(
                        "Produk tidak ditemukan",
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return _buildProductItem(product);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(Product product) {
    final cartManager = CartManager();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(14)),
            child: Image.asset(
              product.imageUrl,
              width: 110,
              height: 110,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.image, color: Colors.white70),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _formatRupiah(product.price),
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 36,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Hanya tambah ke keranjang, tidak pindah halaman
                        cartManager.addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.name} ditambahkan ke keranjang'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_shopping_cart, size: 18),
                      label: const Text("Add"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
}