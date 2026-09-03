import 'package:easy_localization/easy_localization.dart';
import 'package:exercise_5_8_26/core/localization/locale_keys.dart';
import 'package:exercise_5_8_26/enums/ui_state.dart';
import 'package:exercise_5_8_26/features/product/presentation/providers/product_provider.dart';
import 'package:exercise_5_8_26/features/product/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.favoriteScreen.favoriteTitle.tr()),
        centerTitle: true,
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          final favoriteProducts = provider.favoriteProducts;

          if (provider.favoriteProductsState == UiStateEnum.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.favoriteProductsState == UiStateEnum.error) {
            return Center(
              child: Text(LocaleKeys.favoriteScreen.errorMessage.tr()),
            );
          }

          if (favoriteProducts.isEmpty) {
            return Center(
              child: Text(LocaleKeys.favoriteScreen.emptyMessage.tr()),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.7,
            ),
            itemCount: favoriteProducts.length,
            itemBuilder: (context, index) {
              return ProductCard(product: favoriteProducts[index]);
            },
          );
        },
      ),
    );
  }
}
