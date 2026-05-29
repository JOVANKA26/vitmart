import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitmart/main.dart';
import 'package:vitmart/screens/signin_screen.dart';
import 'package:vitmart/screens/admin_screen.dart';
import 'package:vitmart/utils/encryption_helper.dart';
import 'package:vitmart/utils/favorite_manager.dart';
import 'package:vitmart/utils/cart_manager.dart'; // tambahkan

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
    await Future.delayed(const Duration(seconds: 2));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encryptedEmail = prefs.getString("email");
    String? encryptedPassword = prefs.getString("password");

    if (encryptedEmail == null || encryptedPassword == null) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SignInScreen()),
        );
      }
      return;
    }

    String email = EncryptionHelper.decryptText(encryptedEmail);

    // Set user untuk FavoriteManager dan CartManager
    await FavoriteManager().setUser(email);
    await CartManager().setUser(email); // <-- tambahkan ini

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
      backgroundColor: const Color(0xFFE91D1D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/vitmart.jpg", width: 180),
            const SizedBox(height: 20),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}