import 'package:flutter/material.dart';

class MetodepengirimanScreen extends StatelessWidget {
  final String selected;

  MetodepengirimanScreen({required this.selected});

  @override
  Widget build(BuildContext context) {
    List<String> methods = [
      "Hemat Kargo",
      "SiCepat",
      "VitExpress",
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Pilih Metode Pengiriman"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: ListView(
        children: methods.map((m) {
          return ListTile(
            title: Text(m, style: TextStyle(color: Colors.white)),
            trailing: (selected == m)
                ? Icon(Icons.check, color: Colors.white)
                : null,
            onTap: () {
              Navigator.pop(context, m);
            },
          );
        }).toList(),
      ),
    );
  }
}