import 'package:flutter/material.dart';
import '../screens/search_screen.dart';

class SearchBarWidget extends StatelessWidget {
  // ====================
  // PARAMETER LAMA
  // ====================
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onMessageTap;

  // ====================
  // PARAMETER BARU (OPTIONAL)
  // ====================
  final bool showBackButton;
  final bool showMessageIcon;
  final VoidCallback? onBackTap;

  const SearchBarWidget({
    super.key,
    this.onChanged,
    this.onSubmitted,
    this.onMessageTap,

    // default agar TIDAK MERUSAK pemakaian lama
    this.showBackButton = false,
    this.showMessageIcon = true,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        // ================================
        // ⬅️ BACK BUTTON (OPTIONAL)
        // ================================
        if (showBackButton)
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: onBackTap ?? () => Navigator.pop(context),
          ),

        // ================================
        // SEARCH BAR FULL STYLE HP
        // ================================
        Expanded(
          child: GestureDetector(
            onTap: () {
              // JIKA tidak dipakai untuk search langsung
              if (onChanged == null && onSubmitted == null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SearchScreen(),
                  ),
                );
              }
            },
            child: AbsorbPointer(
              absorbing: onChanged == null && onSubmitted == null,
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: TextField(
                  onChanged: onChanged,
                  onSubmitted: onSubmitted,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.search, color: Colors.black54),
                    hintText: "Search...",
                    hintStyle:
                        TextStyle(color: Colors.grey.shade500),
                    border: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        // ================================
        // ICON NOTIF (OPTIONAL)
        // ================================
        if (showMessageIcon)
          GestureDetector(
            onTap: onMessageTap,
            child: Stack(
              children: [
                const Icon(
                  Icons.mail_outline,
                  size: 28,
                  color: Colors.white,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor: Colors.red,
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }
}
