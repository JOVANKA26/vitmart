import 'package:flutter/material.dart';
import 'package:vitmart/main.dart';
import 'package:vitmart/screens/payment_screen.dart';
import 'package:vitmart/utils/cart_manager.dart';
import 'package:vitmart/models/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartManager = CartManager();
    const int pajak = 2500;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainScreen()),
          ),
        ),
        title: const Text("Cart", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<List<CartItem>>(
        valueListenable: cartManager.cartItems,
        builder: (context, cartItems, _) {
          final subtotal = cartManager.subtotal;
          final total = (subtotal + pajak).toInt();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: const Text(
                  "PEMBAYARAN",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ),
              const Divider(color: Colors.white24),

              // List item
              Expanded(
                child: cartItems.isEmpty
                    ? const Center(
                        child: Text(
                          "Keranjang kosong",
                          style: TextStyle(color: Colors.white70),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return _CartItemCard(
                            item: item,
                            onIncrement: () => cartManager.addToCart(item.product),
                            onDecrement: () => cartManager.removeOneFromCart(item.product),
                            onRemove: () => cartManager.removeItemCompletely(item.product),
                          );
                        },
                      ),
              ),

              const Divider(color: Colors.white24),

              // Ringkasan harga
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    PriceRow(
                      label: "Subtotal (${cartManager.totalItems})",
                      price: subtotal.toInt(),
                    ),
                    const SizedBox(height: 6),
                    const PriceRow(label: "Pajak", price: pajak),
                    const SizedBox(height: 6),
                    PriceRow(label: "Total", price: total, isBold: true),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      // Tombol Checkout di bottomNavigationBar agar tidak bertabrakan
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            height: 55,
            child: ValueListenableBuilder<List<CartItem>>(
              valueListenable: cartManager.cartItems,
              builder: (context, cartItems, _) {
                return ElevatedButton(
                  onPressed: cartItems.isEmpty
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PaymentScreen(
                                total: (cartManager.subtotal + pajak).toInt(),
                                method: "Pilih Metode",
                              ),
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// Widget untuk item keranjang (sama seperti sebelumnya)
class _CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const _CartItemCard({
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
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
              item.product.imageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.image, color: Colors.white70),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 3),
                Text(
                  "${item.product.category} · ${item.product.subCategory}",
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 3),
                Text(
                  "Jumlah: ${item.quantity}",
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Rp ${_formatRupiah(item.totalPrice.toInt())}",
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline, color: Colors.white70),
                    onPressed: onDecrement,
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline, color: Colors.white70),
                    onPressed: onIncrement,
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: onRemove,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatRupiah(int number) {
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
}

class PriceRow extends StatelessWidget {
  final String label;
  final int price;
  final bool isBold;

  const PriceRow({super.key, required this.label, required this.price, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        Text("Rp ${_formatRupiah(price)}", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  String _formatRupiah(int number) {
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
}