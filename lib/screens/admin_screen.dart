import 'package:flutter/material.dart';
import 'package:vitmart/screens/signin_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // APPBAR CUSTOM
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // TODO: back
            Navigator.pop(context);
          },
        ),
      ),

      // BODY
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 50),

              const Text(
                "Admin",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 100),

              // BUTTON TAMBAH PRODUK
              buttonAdmin(
                icon: Icons.add_circle_outline,
                label: "Tambah Produk",
                onPressed: () {
                  // TODO: aksi tambah produk
                },
              ),

              const SizedBox(height: 50),

              // BUTTON EDIT PRODUK
              buttonAdmin(
                icon: Icons.edit_outlined,
                label: "Edit Produk",
                onPressed: () {
                  // TODO: aksi edit produk
                },
              ),

              const SizedBox(height: 50),

              // BUTTON HAPUS PRODUK
              buttonAdmin(
                icon: Icons.remove_circle_outline,
                label: "Hapus Produk",
                onPressed: () {
                  // TODO: aksi hapus produk
                },
              ),
              
              const SizedBox(height: 100),

              OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignInScreen()),
                );
              },
              child: const Text("Sign out"),
            ),
            ],
          ),
        ),
      ),
    );
  }

  // WIDGET TOMBOL ADMIN
  Widget buttonAdmin({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(width: 15),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}