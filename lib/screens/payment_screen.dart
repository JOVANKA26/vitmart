import 'package:flutter/material.dart';
import 'package:vitmart/screens/metodePembayaran_screen.dart';
import 'package:vitmart/screens/metodePengiriman_screen.dart';
import 'package:vitmart/screens/pesananDibuat_screen.dart';

class PaymentScreen extends StatefulWidget {
  final int total;
  final String method;

  PaymentScreen({required this.total, required this.method});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Checkout", style: TextStyle(color: Colors.white)),
      ),

      body: ListView(
        children: [
          // ================= ALAMAT =================
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.black,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on_outlined, color: Colors.white),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Mangala Vira\nKost Laguna, Jalan Bangau No.371, Palembang 30113",
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
              ],
            ),
          ),

          SizedBox(height: 10),

          // ================ TOKO + PRODUK ================
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "VitMart",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 12),

                Row(
                  children: [
                    Image.asset(
                      "images/Chitato.jpg",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Makanan",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 5),
                          Text("x1", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    Text("Rp10.000", style: TextStyle(color: Colors.white)),
                  ],
                ),
                
                SizedBox(height: 16),

                Row(
                  children: [
                    Image.asset(
                      "images/Bigbabol.jpg",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Makanan",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 5),
                          Text("x1", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    Text("Rp2.500", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          // ================= PENGIRIMAN =================
          InkWell(
            onTap: () async {
              String? result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      MetodepengirimanScreen(selected: selectedPengiriman),
                ),
              );

              if (result != null) {
                setState(() => selectedPengiriman = result);
              }
            },
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Metode Pengiriman",
                    style: TextStyle(color: Colors.white),
                  ),
                  Row(
                    children: [
                      Text(
                        selectedPengiriman,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 10),

          SizedBox(height: 10),

          // ================= METODE PEMBAYARAN =================
          InkWell(
            onTap: () async {
              String? result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      MetodePembayaranScreen(selected: selectedPembayaran),
                ),
              );

              if (result != null) {
                setState(() => selectedPembayaran = result);
              }
            },
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Metode Pembayaran",
                    style: TextStyle(color: Colors.white),
                  ),
                  Row(
                    children: [
                      Text(
                        selectedPembayaran,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 10),

          // ================= RINCIAN PEMBAYARAN ================
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Rincian Pembayaran",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12),

                paymentRow(
                  "Subtotal",
                  "Rp${widget.total - 2500}",
                  style: TextStyle(color: Colors.white),
                ),
                paymentRow(
                  "Pajak",
                  "Rp2.500",
                  style: TextStyle(color: Colors.white),
                ),
              
                Divider(),
                paymentRow(
                  "Total Pembayaran",
                  "Rp${widget.total}",
                  bold: true,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          SizedBox(height: 80),
        ],
      ),

      // ================= BOTTOM BUTTON =================
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black12)),
          color: Colors.white,
        ),
        child: Transform.translate(
          offset: const Offset(0, -10), // ⬅ NAIK KE ATAS
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  const PesananDibuatScreen(),
                  ),
                );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Buat Pesanan",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget paymentRow(
    String label,
    String value, {
    bool bold = false,
    TextStyle? style,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.white)),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: style?.color,
            ),
          ),
        ],
      ),
    );
  }
}