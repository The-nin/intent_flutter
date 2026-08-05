import 'package:flutter/material.dart';
import '../data/fake_data.dart';
import '../widgets/banner_slider.dart';
import '../widgets/product_card.dart';
import '../widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchKeyword = '';

  @override
  Widget build(BuildContext context) {
    final filteredProducts = fakeProducts
        .where((p) =>
            p.name.toLowerCase().contains(_searchKeyword.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            CustomSearchBar(
              onChanged: (value) => setState(() => _searchKeyword = value),
            ),

            BannerSlider(images: bannerImages),

            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sản phẩm nổi bật',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            Expanded(
              child: filteredProducts.isEmpty
                  ? const Center(child: Text('Không tìm thấy sản phẩm'))
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredProducts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        return ProductCard(product: filteredProducts[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}