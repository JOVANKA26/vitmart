import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitmart/main.dart';
import 'package:vitmart/screens/signin_screen.dart';
import 'package:vitmart/screens/admin_screen.dart';
import 'package:vitmart/utils/encryption_helper.dart';
import 'package:vitmart/utils/favorite_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginAndNavigate();
  }

  Future<void> _checkLoginAndNavigate() async {
    // Tunggu 2 detik agar splash terlihat
    await Future.delayed(const Duration(seconds: 2));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encryptedEmail = prefs.getString("email");
    String? encryptedPassword = prefs.getString("password");

    // Jika belum ada akun tersimpan
    if (encryptedEmail == null || encryptedPassword == null) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SignInScreen()),
        );
      }
      return;
    }

    // Dekripsi email
    String email = EncryptionHelper.decryptText(encryptedEmail);
    // (password tidak diperlukan untuk routing, hanya untuk validasi)

    // Set user ke FavoriteManager (agar favorit dimuat)
    await FavoriteManager().setUser(email);

    // Routing berdasarkan domain email
    if (email.endsWith("@gmail.adm.co.id")) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AdminScreen()),
        );
      }
    } else if (email.endsWith("@gmail.co.id")) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MyApp()),
        );
      }
    } else {
      // Domain tidak dikenali, minta login ulang
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SignInScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE91D1D), // background merah
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
            // Loading indicator
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}