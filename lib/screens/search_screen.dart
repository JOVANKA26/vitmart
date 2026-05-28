import 'package:flutter/material.dart';
import '../widgets/search_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = "";

  // CART SEMENTARA
  final List<Map<String, String>> cartItems = [];

  final List<Map<String, String>> products = [
    {
      "image": "images/Chitato.jpg",
      "name": "Chitato",
      "price": "RP 10.000",
    },
    {
      "image": "images/Bigbabol.jpg",
      "name": "Big Babol",
      "price": "RP 2.500",
    },
    {
      "image": "images/Kacang.jpg",
      "name": "Kacang Garuda",
      "price": "RP 7.000",
    },
    {
      "image": "images/Khongguan.jpg",
      "name": "Khong Guan",
      "price": "RP 55.000",
    },
    {
      "image": "images/Cocacola.jpg",
      "name": "Cocacola",
      "price": "RP 6.000",
    },
    {
      "image": "images/Fanta.jpg",
      "name": "Fanta",
      "price": "RP 11.000",
    },
    {
      "image": "images/Golda.png",
      "name": "Golda",
      "price": "RP 5.000",
    },
    {
      "image": "images/Minerale.webp",
      "name": "Le Minerale",
      "price": "RP 8.000",
    },
    {
      "image": "images/Mylanta.jpg",
      "name": "Mylanta",
      "price": "RP 5.000",
    },
    {
      "image": "images/Obhcombi.webp",
      "name": "OBH Combi",
      "price": "RP 18.000",
    },
    {
      "image": "images/Tolakangin.jpg",
      "name": "Tolak Angin",
      "price": "RP 2.500",
    },
    {
      "image": "images/Oskadon.jpg",
      "name": "Oskadon",
      "price": "RP 12.500",
    },
    {
      "image": "images/Hotwheels.webp",
      "name": "Hot Wheels",
      "price": "RP 30.000",
    },
    {
      "image": "images/Uno.webp",
      "name": "Uno",
      "price": "RP 15.000",
    },
    {
      "image": "images/Pokemon.webp",
      "name": "Kartu Pokemon",
      "price": "RP 25.000",
    },
    {
      "image": "images/Boboiboy.jpg",
      "name": "Kartu Boboiboy",
      "price": "RP 20.000",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((product) {
      return product["name"]!
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // ================= SEARCH BAR + BACK =================
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

            // ================= HASIL SEARCH =================
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

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.white12),
                          ),
                          child: Row(
                            children: [
                              // IMAGE
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.horizontal(
                                  left: Radius.circular(14),
                                ),
                                child: Image.asset(
                                  product["image"]!,
                                  width: 110,
                                  height: 110,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              const SizedBox(width: 12),

                              // INFO + BUTTON
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product["name"]!,
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
                                        product["price"]!,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(height: 10),

                                      // ADD TO CART BUTTON
                                      SizedBox(
                                        height: 36,
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            setState(() {
                                              cartItems.add(product);
                                            });

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "${product["name"]} ditambahkan ke keranjang"),
                                                duration:
                                                    const Duration(seconds: 1),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.add_shopping_cart,
                                            size: 18,
                                          ),
                                          label: const Text("Add"),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            foregroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
