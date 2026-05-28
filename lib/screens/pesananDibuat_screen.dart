import 'package:flutter/material.dart';
import 'package:vitmart/main.dart';
import 'package:vitmart/screens/cart_screen.dart';

class PesananDibuatScreen extends StatelessWidget {
  const PesananDibuatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesanan"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 16),
            const Text(
              "Pesanan berhasil dibuat",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                  (route) => false,
                );
              },
              child: const Text("Kembali ke Beranda"),
            ),
          ],
        ),
      ),
    );
  }
}