import 'package:flutter/material.dart';
import 'package:vitmart/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
void initState() {
  super.initState();
  Future.delayed(const Duration(seconds: 2), () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MyApp()),
    );
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE91D1D), // background merah seperti gambar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              "images/vitmart.jpg",
              width: 180,
            ),

            const SizedBox(height: 20),

            // Loading progress indicator
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
