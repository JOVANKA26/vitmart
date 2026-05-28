import 'package:flutter/material.dart';
import 'package:vitmart/main.dart';
import 'payment_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  // DATA CART (contoh)
  final List<int> cartPrices = const [10000, 2500];
  final int pajak = 2500;

  @override
  Widget build(BuildContext context) {
    int subtotal = cartPrices.fold(0, (a, b) => a + b);
    int total = subtotal + pajak;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MainScreen()),
            );
          },
        ),
        title: const Text("Cart", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= PEMBAYARAN =================
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: const Text(
              "PEMBAYARAN",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
          const Divider(color: Colors.white24),

          // ================= PRODUCT LIST =================
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: const [
                CartItem(
                  imagePath: "images/Chitato.jpg",
                  title: "Nama product",
                  description: "Keterangan\nJumlah: 01",
                  price: 10000,
                ),
                CartItem(
                  imagePath: "images/Bigbabol.jpg",
                  title: "Nama product",
                  description: "Keterangan\nJumlah: 01",
                  price: 2500,
                ),
              ],
            ),
          ),

          const Divider(color: Colors.white24),

          // ================= RINGKASAN HARGA =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                PriceRow(
                  label: "Subtotal (${cartPrices.length})",
                  price: subtotal,
                ),
                const SizedBox(height: 6),
                PriceRow(label: "Pajak", price: pajak),
                const SizedBox(height: 6),
                PriceRow(label: "Total", price: total, isBold: true),
              ],
            ),
          ),

          // ================= CHECKOUT =================
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          PaymentScreen(total: total, method: "Pilih Metode"),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Checkout",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= ITEM KERANJANG =================
class CartItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final int price;

  const CartItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          Text(
            "Rp ${formatRupiah(price)}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// ================= BARIS HARGA =================
class PriceRow extends StatelessWidget {
  final String label;
  final int price;
  final bool isBold;

  const PriceRow({
    super.key,
    required this.label,
    required this.price,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          "Rp ${formatRupiah(price)}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

// ================= FORMAT RUPIAH (TANPA REGEXP) =================
String formatRupiah(int number) {
  String s = number.toString();
  String result = '';
  int count = 0;

  for (int i = s.length - 1; i >= 0; i--) {
    result = s[i] + result;
    count++;
    if (count == 3 && i != 0) {
      result = '.$result';
      count = 0;
    }
  }
  return result;
}