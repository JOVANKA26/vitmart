import 'package:flutter/material.dart';

class MetodePembayaranScreen extends StatelessWidget {
  final String selected;

  const MetodePembayaranScreen({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    List<String> methods = ["Transfer Bank", "COD", "VitPay"];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Pilih Metode Pembayaran"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: methods.map((m) {
          return ListTile(
            title: Text(m, style: const TextStyle(color: Colors.white)),
            trailing:
                selected == m ? const Icon(Icons.check, color: Colors.white) : null,
            onTap: () => Navigator.pop(context, m),
          );
        }).toList(),
      ),
    );
  }
}
