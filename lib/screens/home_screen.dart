import 'package:flutter/material.dart';
import '../widgets/search_bar.dart';
import '../widgets/banner_slider.dart';
import '../widgets/category_list.dart';
import '../widgets/product_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  double scrollOffset = 0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      setState(() {
        scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double bannerParallax = scrollOffset * 0.25;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // ================= SEARCH BAR =================
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: SearchBarWidget(),
            ),

            // ================= CONTENT =================
            Expanded(
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ================= BANNER =================
                      Transform.translate(
                        offset: Offset(0, -bannerParallax),
                        child: const BannerSlider(),
                      ),

                      const SizedBox(height: 20),

                      // ================= CATEGORY =================
                      sectionTitle("Kategori", isDark: false),

                      AnimatedOpacity(
                        opacity: scrollOffset > 10 ? 1 : 0.3,
                        duration: const Duration(milliseconds: 300),
                        child: const CategoryList(),
                      ),

                      const SizedBox(height: 30),

                      // ================= PRODUCT =================
                      Container(
                        width: double.infinity,
                        color: Colors.black,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sectionTitle("Product", isDark: true),

                            AnimatedOpacity(
                              opacity: scrollOffset > 30 ? 1 : 0.3,
                              duration: const Duration(milliseconds: 400),
                              child: AnimatedSlide(
                                offset: scrollOffset > 30
                                    ? Offset.zero
                                    : const Offset(0, 0.2),
                                duration:
                                    const Duration(milliseconds: 400),
                                child: const ProductList(searchQuery: ""),
                              ),
                            ),

                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= SECTION TITLE =================
  Widget sectionTitle(String title, {bool isDark = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: isDark ? Colors.white : Colors.black,
          ),
        ],
      ),
    );
  }
}
