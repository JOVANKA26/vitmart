import 'package:flutter/material.dart';
import 'package:vitmart/screens/register_screen.dart';
import 'package:vitmart/screens/home_screen.dart';
import 'package:vitmart/screens/cart_screen.dart';
import 'package:vitmart/screens/favorite_screen.dart';
import 'package:vitmart/screens/profile_screen.dart';
import 'package:vitmart/screens/admin_screen.dart';
import 'package:vitmart/screens/signin_screen.dart';
import 'package:vitmart/screens/splash_screen.dart';
import 'package:vitmart/utils/favorite_manager.dart';
import 'package:vitmart/models/product.dart'; 

void main() {
  runApp(const MyAppStart());
}

// ==================== SPLASH WRAPPER ====================
class MyAppStart extends StatelessWidget {
  const MyAppStart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

// ==================== MAIN APP (SETELAH SPLASH) ====================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RegisterScreen(),
    );
  }
}

// ==================== MAIN SCREEN DENGAN BOTTOM NAV ====================
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  final screens = const [
    HomeScreen(),
    CartScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black54,
          currentIndex: index,
          onTap: (value) => setState(() => index = value),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
          ],
        ),
      ),
    );
  }
}