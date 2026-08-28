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
      appBar: AppBar(title: const Text('Favorite Products'), centerTitle: true),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          final favoriteProducts = provider.favoriteProducts;

          if (provider.favoriteProductsState == UiStateEnum.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.favoriteProductsState == UiStateEnum.error) {
            return const Center(child: Text("Cannot load favorite products."));
          }

          if (favoriteProducts.isEmpty) {
            return const Center(child: Text('No favorite products yet.'));
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
