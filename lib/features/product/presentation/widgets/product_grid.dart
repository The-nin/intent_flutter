import 'package:easy_localization/easy_localization.dart';
import 'package:exercise_5_8_26/core/localization/locale_keys.dart';
import 'package:exercise_5_8_26/enums/ui_state.dart';
import 'package:exercise_5_8_26/features/product/domain/entities/product.dart';
import 'package:exercise_5_8_26/features/product/presentation/providers/product_provider.dart';
import 'package:exercise_5_8_26/features/product/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key, required this.searchKeyword});

  final String searchKeyword;

  @override
  Widget build(BuildContext context) {
    final state = context.select<ProductProvider, UiStateEnum>(
      (provider) => provider.productsState,
    );

    final products = context.select<ProductProvider, List<Product>>(
      (provider) => provider.products,
    );

    if (state == UiStateEnum.loading) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state == UiStateEnum.error) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                LocaleKeys.products.emptyMessage.tr(),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.read<ProductProvider>().getProducts();
                },
                child: Text(LocaleKeys.common.retry.tr()),
              ),
            ],
          ),
        ),
      );
    }

    if (state == UiStateEnum.empty) {
      return SliverFillRemaining(
        child: Center(child: Text(LocaleKeys.products.emptyMessage.tr())),
      );
    }

    final keyword = searchKeyword.toLowerCase();

    final filteredProducts = products.where((product) {
      return product.title.toLowerCase().contains(keyword);
    }).toList();

    if (filteredProducts.isEmpty) {
      return SliverFillRemaining(
        child: Center(child: Text(LocaleKeys.products.emptyMessage.tr())),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          return ProductCard(product: filteredProducts[index]);
        }, childCount: filteredProducts.length),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.7,
        ),
      ),
    );
  }
}
