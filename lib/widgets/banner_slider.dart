import 'package:flutter/material.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: PageView(
        children: [
          bannerItem("VitMart",
              "https://images.unsplash.com/photo-1504754524776-8f4f37790ca0"),
        ],
      ),
    );
  }

  Widget bannerItem(String title, String imgUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.network(imgUrl,
                width: double.infinity, height: 170, fit: BoxFit.cover),
            Positioned(
              bottom: 40,
              left: 70,
              child: Text(
                title,
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 0, 0),
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
