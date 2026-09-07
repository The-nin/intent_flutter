import 'package:easy_localization/easy_localization.dart';
import 'package:exercise_5_8_26/core/localization/locale_keys.dart';
import 'package:exercise_5_8_26/features/product/presentation/widgets/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:exercise_5_8_26/features/product/presentation/providers/product_provider.dart';
import '../widgets/banner_slider.dart';
import '../widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const route = '/home';

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

  @override
  Widget build(BuildContext context) {
    context.locale;

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.homeScreen.homeTitle.tr()),
        centerTitle: true,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CustomSearchBar(
                onChanged: (value) {
                  setState(() {
                    _searchKeyword = value;
                  });
                },
              ),
            ),

            SliverToBoxAdapter(child: BannerSlider(images: bannerImages)),

            const SliverToBoxAdapter(child: SizedBox(height: 8)),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    LocaleKeys.homeScreen.featuredProducts.tr(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            ProductGrid(searchKeyword: _searchKeyword),
          ],
        ),
      ),
    );
  }
}
