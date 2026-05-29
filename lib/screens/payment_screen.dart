import 'package:flutter/material.dart';
import 'package:vitmart/screens/metodePembayaran_screen.dart';
import 'package:vitmart/screens/metodePengiriman_screen.dart';
import 'package:vitmart/screens/pesananDibuat_screen.dart';
import 'package:vitmart/utils/cart_manager.dart';
import 'package:vitmart/models/cart_item.dart';

class PaymentScreen extends StatefulWidget {
  final int total;
  final String method;

  const PaymentScreen({super.key, required this.total, required this.method});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late String selectedMethod;
  String selectedPengiriman = "Pilih Pengiriman";
  String selectedPembayaran = "Pilih Pembayaran";

  @override
  void initState() {
    super.initState();
    selectedMethod = widget.method;
  }

  bool get isButtonEnabled {
    return selectedPengiriman != "Pilih Pengiriman" && selectedPembayaran != "Pilih Pembayaran";
  }

  @override
  Widget build(BuildContext context) {
    final cartManager = CartManager();
    final cartItems = cartManager.cartItems.value;
    const int pajak = 2500;
    final int subtotal = cartItems.fold(0, (sum, item) => sum + (item.product.price * item.quantity).toInt());
    final int total = subtotal + pajak;

    final double screenWidth = MediaQuery.of(context).size.width;
    final double basePadding = screenWidth * 0.04;
    final double baseMargin = screenWidth * 0.02;
    final double imageSize = screenWidth * 0.15;
    final double fontSizeLabel = screenWidth * 0.035;
    final double fontSizeTitle = screenWidth * 0.045;
    final double fontSizeSmall = screenWidth * 0.03;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Checkout", style: TextStyle(color: Colors.white, fontSize: fontSizeTitle)),
      ),
      body: ListView(
        children: [
          // ALAMAT
          Container(
            padding: EdgeInsets.all(basePadding),
            color: Colors.black,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on_outlined, color: Colors.white),
                SizedBox(width: basePadding),
                Expanded(
                  child: Text(
                    "Mangala Vira\nKost Laguna, Jalan Bangau No.371, Palembang 30113",
                    style: TextStyle(fontSize: fontSizeSmall, color: Colors.white),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
              ],
            ),
          ),
          SizedBox(height: baseMargin),

          // TOKO + PRODUK
          Container(
            padding: EdgeInsets.all(basePadding),
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "VitMart",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: fontSizeLabel),
                ),
                SizedBox(height: baseMargin),
                ...cartItems.map((cartItem) => Padding(
                  padding: EdgeInsets.only(bottom: baseMargin),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          cartItem.product.imageUrl,
                          width: imageSize,
                          height: imageSize,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.image, color: Colors.white70),
                        ),
                      ),
                      SizedBox(width: basePadding),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartItem.product.name,
                              style: TextStyle(color: Colors.white, fontSize: fontSizeLabel),
                            ),
                            SizedBox(height: baseMargin * 0.5),
                            Text(
                              "${cartItem.product.category} · ${cartItem.product.subCategory}",
                              style: TextStyle(color: Colors.white70, fontSize: fontSizeSmall),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "x${cartItem.quantity}",
                        style: TextStyle(color: Colors.white, fontSize: fontSizeSmall),
                      ),
                      SizedBox(width: baseMargin),
                      Text(
                        "Rp${_formatRupiah((cartItem.product.price * cartItem.quantity).toInt())}",
                        style: TextStyle(color: Colors.white, fontSize: fontSizeLabel),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
          SizedBox(height: baseMargin),

          // METODE PENGIRIMAN
          InkWell(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MetodepengirimanScreen(selected: selectedPengiriman)),
              );
              if (result != null) setState(() => selectedPengiriman = result);
            },
            child: Container(
              padding: EdgeInsets.all(basePadding),
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Metode Pengiriman", style: TextStyle(color: Colors.white, fontSize: fontSizeLabel)),
                  Row(
                    children: [
                      Text(selectedPengiriman, style: TextStyle(color: Colors.white, fontSize: fontSizeLabel)),
                      SizedBox(width: baseMargin),
                      const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: baseMargin),

          // METODE PEMBAYARAN
          InkWell(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MetodePembayaranScreen(selected: selectedPembayaran)),
              );
              if (result != null) setState(() => selectedPembayaran = result);
            },
            child: Container(
              padding: EdgeInsets.all(basePadding),
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Metode Pembayaran", style: TextStyle(color: Colors.white, fontSize: fontSizeLabel)),
                  Row(
                    children: [
                      Text(selectedPembayaran, style: TextStyle(color: Colors.white, fontSize: fontSizeLabel)),
                      SizedBox(width: baseMargin),
                      const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: baseMargin),

          // RINCIAN PEMBAYARAN
          Container(
            padding: EdgeInsets.all(basePadding),
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Rincian Pembayaran",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: fontSizeLabel),
                ),
                SizedBox(height: baseMargin),
                paymentRow("Subtotal (${cartItems.fold(0, (sum, item) => sum + item.quantity)})", "Rp${_formatRupiah(subtotal)}", fontSizeLabel, fontSizeSmall),
                paymentRow("Pajak", "Rp${_formatRupiah(pajak)}", fontSizeLabel, fontSizeSmall),
                const Divider(color: Colors.white24),
                paymentRow("Total Pembayaran", "Rp${_formatRupiah(total)}", fontSizeLabel, fontSizeSmall, bold: true),
              ],
            ),
          ),
          SizedBox(height: screenWidth * 0.05), // sedikit space bottom agar tidak terlalu mepet
        ],
      ),
      // ================= BOTTOM BUTTON DI bottomNavigationBar =================
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(basePadding),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black12)),
            color: Colors.white,
          ),
          child: ElevatedButton(
            onPressed: isButtonEnabled
                ? () {
                    cartManager.clearCart();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const PesananDibuatScreen()),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isButtonEnabled ? Colors.black : Colors.grey.shade500,
              padding: EdgeInsets.symmetric(vertical: screenWidth * 0.035),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              "Buat Pesanan",
              style: TextStyle(color: Colors.white, fontSize: fontSizeLabel),
            ),
          ),
        ),
      ),
    );
  }

  Widget paymentRow(String label, String value, double fontSizeLabel, double fontSizeSmall, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.white70, fontSize: fontSizeSmall)),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: Colors.white,
              fontSize: fontSizeLabel,
            ),
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