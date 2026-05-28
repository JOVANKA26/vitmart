import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final images = [
      "images/Makanan.png",
      "images/Minuman.jpg",
      "images/Obat1.avif",
      "images/Mainan2.png",
    ];

    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: images.length,
        itemBuilder: (context, i) {
          return Container(
            margin: const EdgeInsets.only(right: 18),
            child: Column(
              children: [
                ClipOval(
                  child: Image.asset(
                    images[i],
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Kategori ${i + 1}",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}