import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:exercise_5_8_26/features/product/presentation/providers/product_provider.dart';
import '../widgets/banner_slider.dart';
import '../widgets/product_card.dart';
import '../../../../widgets/search_bar.dart';
import '../../../../enums/ui_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchKeyword = '';

  final List<String> bannerImages = [
    'https://picsum.photos/id/1011/800/400',
    'https://picsum.photos/id/1015/800/400',
    'https://picsum.photos/id/1025/800/400',
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ProductProvider>();

      provider.getProducts();
      provider.loadFavorites();
    });
  }

  Widget _buildBody() {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        final state = provider.productsState;

        if (state == UiStateEnum.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state == UiStateEnum.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Có lỗi xảy ra', style: TextStyle(fontSize: 18)),

                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: provider.getProducts,
                  child: const Text('Thử lại'),
                ),
              ],
            ),
          );
        }

        if (state == UiStateEnum.empty) {
          return const Center(child: Text('Không có sản phẩm'));
        }

        final filteredProducts = provider.products
            .where(
              (p) =>
                  p.title.toLowerCase().contains(_searchKeyword.toLowerCase()),
            )
            .toList();

        return Column(
          children: [
            CustomSearchBar(
              onChanged: (value) {
                setState(() {
                  _searchKeyword = value;
                });
              },
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
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trang chủ'), centerTitle: true),
      body: SafeArea(child: _buildBody()),
    );
  }
}
