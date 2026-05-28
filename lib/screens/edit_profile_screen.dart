import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    nameController.text = prefs.getString("name") ?? "Nama";
    bioController.text = prefs.getString("bio") ?? "Bio";
    phoneController.text = prefs.getString("phone") ?? "";
  }

  Future<void> saveProfile() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("name", nameController.text.trim());
    await prefs.setString("bio", bioController.text.trim());
    await prefs.setString("phone", phoneController.text.trim());

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Profil berhasil diperbarui")));

    Navigator.pop(context); // kembali ke halaman akun
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profil"),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// Nama
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Nama",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Bio
            TextField(
              controller: bioController,
              decoration: InputDecoration(
                labelText: "Bio",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Phone
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Phone",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: saveProfile,
                child: const Text(
                  "Simpan Perubahan",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}