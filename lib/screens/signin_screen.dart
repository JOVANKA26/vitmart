import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vitmart/main.dart';
import 'package:vitmart/screens/home_screen.dart';
import 'package:vitmart/screens/register_screen.dart';
import 'package:vitmart/screens/admin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitmart/utils/encryption_helper.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isChecked = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? encryptedEmail = prefs.getString("email");
    String? encryptedPassword = prefs.getString("password");

    if (encryptedEmail == null || encryptedPassword == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Akun belum terdaftar!")));
      return;
    }

    // 🔓 decrypt
    String savedEmail = EncryptionHelper.decryptText(encryptedEmail);
    String savedPassword = EncryptionHelper.decryptText(encryptedPassword);

    // input user
    String inputEmail = emailController.text.trim();
    String inputPassword = passwordController.text.trim();

    if (inputEmail != savedEmail || inputPassword != savedPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email atau password salah")),
      );
      return;
    }

    // 🔀 ROUTING BERDASARKAN DOMAIN
    if (inputEmail.endsWith("@gmail.adm.co.id")) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const AdminScreen()),
        (route) => false,
      );
    } else if (inputEmail.endsWith("@gmail.co.id")) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Domain email tidak diizinkan")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // LOGO
            Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Image.asset("images/vitmart.jpg")),
              ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Email",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Value",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Value",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  RichText(
                    text: TextSpan(
                      text: 'Belum punya akun? ',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurple,
                      ),
                      children: [
                        TextSpan(
                          text: 'Daftar di sini',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const RegisterScreen(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: signIn,
                      child: const Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}