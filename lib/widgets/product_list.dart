import 'package:flutter/material.dart';
import 'package:vitmart/models/product.dart';
import 'package:vitmart/screens/detail.screen.dart';
import '../utils/category_manager.dart';

class ProductList extends StatelessWidget {
  final String searchQuery;
  const ProductList({super.key, required this.searchQuery});

  // Pemetaan kategori untuk filter
  String _getCategory(String productName) {
    const makanan = ['Chitato', 'Big Babol', 'Kacang Garuda', 'Khong Guan'];
    const minuman = ['Cocacola', 'Fanta', 'Golda', 'Le Minerale'];
    const obat = ['Mylanta', 'OBH Combi', 'Tolak Angin', 'Oskadon'];
    const mainan = ['Hot Wheels', 'Uno', 'Kartu Pokemon', 'Kartu Boboiboy'];
    if (makanan.contains(productName)) return 'Makanan';
    if (minuman.contains(productName)) return 'Minuman';
    if (obat.contains(productName)) return 'Obat-obatan';
    if (mainan.contains(productName)) return 'Mainan';
    return 'Makanan';
  }

  String _getSubCategory(String productName) {
    switch (productName) {
      case 'Chitato': return 'Snack';
      case 'Big Babol': return 'Permen';
      case 'Kacang Garuda': return 'Snack';
      case 'Khong Guan': return 'Biskuit';
      case 'Cocacola': return 'Soda';
      case 'Fanta': return 'Soda';
      case 'Golda': return 'Susu';
      case 'Le Minerale': return 'Air Mineral';
      case 'Mylanta': return 'Obat Maag';
      case 'OBH Combi': return 'Obat Batuk';
      case 'Tolak Angin': return 'Herbal';
      case 'Oskadon': return 'Obat';
      case 'Hot Wheels': return 'Mobil';
      case 'Uno': return 'Kartu';
      case 'Kartu Pokemon': return 'Kartu';
      case 'Kartu Boboiboy': return 'Kartu';
      default: return 'Umum';
    }
  }

  String _getEmoji(String productName) {
    switch (productName) {
      case 'Chitato': return '🍟';
      case 'Big Babol': return '🍬';
      case 'Kacang Garuda': return '🥜';
      case 'Khong Guan': return '🍪';
      case 'Cocacola': return '🥤';
      case 'Fanta': return '🍊';
      case 'Golda': return '🥛';
      case 'Le Minerale': return '💧';
      case 'Mylanta': return '💊';
      case 'OBH Combi': return '🌿';
      case 'Tolak Angin': return '🌱';
      case 'Oskadon': return '💊';
      case 'Hot Wheels': return '🚗';
      case 'Uno': return '🃏';
      case 'Kartu Pokemon': return '⚡';
      case 'Kartu Boboiboy': return '🌀';
      default: return '📦';
    }
  }

  String _getDescription(String productName) {
    switch (productName) {
      case 'Chitato':
        return '🍟 **Chitato** – Keripik kentang premium dengan rasa ayam panggang. Terbuat dari kentang pilihan, digoreng hingga renyah, dibumbui rempah alami.';
      case 'Big Babol':
        return '🍬 **Big Babol** – Permen susu kenyal rasa stroberi. Mengandung susu asli dan ekstrak buah stroberi.';
      case 'Kacang Garuda':
        return '🥜 **Kacang Garuda** – Kacang tanah pilihan dengan kulit tipis, digoreng kering dan dibumbui bawang putih.';
      case 'Khong Guan':
        return '🍪 **Khong Guan** – Biskuit asin klasik dengan rasa gurih. Terbuat dari tepung terigu, margarin, dan sedikit gula.';
      case 'Cocacola':
        return '🥤 **Coca‑Cola** – Minuman bersoda berkarbonasi. Mengandung gula asli, kafein, dan ekstrak kola.';
      case 'Fanta':
        return '🍊 **Fanta** – Minuman rasa jeruk dengan soda. Tanpa kafein, pewarna alami karoten.';
      case 'Golda':
        return '🥛 **Golda** – Susu kotak rasa cokelat dan stroberi. Tinggi kalsium.';
      case 'Le Minerale':
        return '💧 **Le Minerale** – Air mineral alkali dengan pH alami. Mengandung magnesium, kalsium, bikarbonat.';
      case 'Mylanta':
        return '💊 **Mylanta** – Obat maag dengan aluminium hidroksida dan magnesium hidroksida.';
      case 'OBH Combi':
        return '🌿 **OBH Combi** – Obat batuk berdahak dan tidak berdahak. Sirup rasa jeruk.';
      case 'Tolak Angin':
        return '🌱 **Tolak Angin** – Herbal untuk masuk angin. Jahe, kencur, kayu manis, daun mint, madu.';
      case 'Oskadon':
        return '💊 **Oskadon** – Parasetamol 500 mg untuk demam, sakit kepala, nyeri otot.';
      case 'Hot Wheels':
        return '🚗 **Hot Wheels** – Mobil mainan die‑cast skala 1:64.';
      case 'Uno':
        return '🃏 **UNO** – Kartu permainan keluarga dengan 108 kartu.';
      case 'Kartu Pokemon':
        return '⚡ **Kartu Pokemon** – Kartu koleksi perdagangan (TCG).';
      case 'Kartu Boboiboy':
        return '🌀 **Kartu Boboiboy** – Kartu bertema animasi populer Malaysia.';
      default:
        return 'Produk berkualitas dari VitMart.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> products = [
      {"image": "images/Chitato.jpg", "name": "Chitato", "price": "RP 10.000"},
      {"image": "images/Bigbabol.jpg", "name": "Big Babol", "price": "RP 2.500"},
      {"image": "images/Kacang.jpg", "name": "Kacang Garuda", "price": "RP 7.000"},
      {"image": "images/Khongguan.jpg", "name": "Khong Guan", "price": "RP 55.000"},
      {"image": "images/Cocacola.jpg", "name": "Cocacola", "price": "RP 6.000"},
      {"image": "images/Fanta.jpg", "name": "Fanta", "price": "RP 11.000"},
      {"image": "images/Golda.png", "name": "Golda", "price": "RP 5.000"},
      {"image": "images/Minerale.webp", "name": "Le Minerale", "price": "RP 8.000"},
      {"image": "images/Mylanta.jpg", "name": "Mylanta", "price": "RP 5.000"},
      {"image": "images/Obhcombi.webp", "name": "OBH Combi", "price": "RP 18.000"},
      {"image": "images/Tolakangin.jpg", "name": "Tolak Angin", "price": "RP 2.500"},
      {"image": "images/Oskadon.jpg", "name": "Oskadon", "price": "RP 12.500"},
      {"image": "images/Hotwheels.webp", "name": "Hot Wheels", "price": "RP 30.000"},
      {"image": "images/Uno.webp", "name": "Uno", "price": "RP 15.000"},
      {"image": "images/Pokemon.webp", "name": "Kartu Pokemon", "price": "RP 25.000"},
      {"image": "images/Boboiboy.jpg", "name": "Kartu Boboiboy", "price": "RP 20.000"},
    ];

    return ValueListenableBuilder(
      valueListenable: CategoryManager.selectedCategory,
      builder: (context, selectedCategory, _) {
        List<Map<String, String>> filteredByCat = products;
        if (selectedCategory != '0') {
          String targetCategory = '';
          if (selectedCategory == '1') targetCategory = 'Makanan';
          else if (selectedCategory == '2') targetCategory = 'Minuman';
          else if (selectedCategory == '3') targetCategory = 'Obat-obatan';
          else if (selectedCategory == '4') targetCategory = 'Mainan';
          filteredByCat = products.where((p) => _getCategory(p["name"]!) == targetCategory).toList();
        }
        final filteredProducts = filteredByCat.where((p) => p["name"]!.toLowerCase().contains(searchQuery.toLowerCase())).toList();

        if (filteredProducts.isEmpty) {
          return const SizedBox(height: 120, child: Center(child: Text("Produk tidak ditemukan", style: TextStyle(color: Colors.white70))));
        }

        return SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filteredProducts.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final productMap = filteredProducts[index];
              double price = 0;
              final priceStr = productMap["price"]!.replaceAll(RegExp(r'[^0-9]'), '');
              if (priceStr.isNotEmpty) price = double.tryParse(priceStr) ?? 0;

              final product = Product(
                id: index.toString(),
                name: productMap["name"]!,
                category: _getCategory(productMap["name"]!),
                subCategory: _getSubCategory(productMap["name"]!),
                emoji: _getEmoji(productMap["name"]!),
                price: price,
                description: _getDescription(productMap["name"]!),
                imageUrl: productMap["image"]!,
              );

              return GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(product: product))),
                child: Container(
                  width: 160,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(14)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                        child: Image.asset(
                          productMap["image"]!,
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(productMap["name"]!, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(productMap["price"]!, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}