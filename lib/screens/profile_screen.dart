import 'package:flutter/material.dart';
import 'package:vitmart/main.dart';
import 'package:vitmart/screens/edit_profile_screen.dart';
import 'package:vitmart/screens/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "";
  String bio = "";
  String phone = "";

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name") ?? "";
      bio = prefs.getString("bio") ?? "";
      phone = prefs.getString("phone") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MainScreen()
              ),
            );
          },
        ),
      ),

      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Akun",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 100),

            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.deepPurple,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),

            const SizedBox(height: 10),

            Text(
              "Nama : ${name.isEmpty ? '-' : name}",
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              "Bio : ${bio.isEmpty ? '-' : bio}",
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              "Phone : ${bio.isEmpty ? '-' : phone}",
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),

            const SizedBox(height: 20),

            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
              ),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                );
                loadProfile();
              },
              child: const Text("Edit profil"),
            ),

            const SizedBox(height: 15),

            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
              ),
              onPressed: () async {
                await SharedPreferences.getInstance();

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
    );
  }
}