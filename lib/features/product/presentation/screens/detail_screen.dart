import 'package:easy_localization/easy_localization.dart';
import 'package:exercise_5_8_26/core/localization/locale_keys.dart';
import 'package:exercise_5_8_26/enums/ui_state.dart';
import 'package:exercise_5_8_26/features/product/presentation/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().getProductById(widget.productId);
    });
  }

  Future<void> _toggleFavorite() async {
    await context.read<ProductProvider>().toggleFavorite(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        final state = provider.productDetailState;
        final product = provider.product;
        final colors = Theme.of(context).colorScheme;

        if (state == UiStateEnum.loading) {
          return Scaffold(
            appBar: AppBar(
              title: Text(LocaleKeys.detailScreen.detailTitle.tr()),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state == UiStateEnum.error) {
          return Scaffold(
            appBar: AppBar(
              title: Text(LocaleKeys.detailScreen.detailTitle.tr()),
            ),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LocaleKeys.products.errorMessage.tr(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      provider.getProductById(widget.productId);
                    },
                    child: Text(LocaleKeys.products.tryAgainButton.tr()),
                  ),
                ],
              ),
            ),
          );
        }

        if (state == UiStateEnum.empty || product == null) {
          return Scaffold(
            appBar: AppBar(
              title: Text(LocaleKeys.detailScreen.detailTitle.tr()),
            ),
            body: Center(child: Text(LocaleKeys.products.emptyMessage.tr())),
          );
        }

        final isFavorite = provider.isFavorite(product.id);

        return Scaffold(
          appBar: AppBar(title: Text(product.title)),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  product.thumbnail,
                  width: double.infinity,
                  height: 280,
                  fit: BoxFit.cover,

                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return const SizedBox(
                      width: double.infinity,
                      height: 280,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },

                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      width: double.infinity,
                      height: 280,
                      child: Center(
                        child: Icon(Icons.image_not_supported, size: 56),
                      ),
                    );
                  },
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              product.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          Column(
                            children: [
                              IconButton(
                                onPressed: _toggleFavorite,
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFavorite
                                      ? colors.error
                                      : colors.onSurfaceVariant,
                                  size: 28,
                                ),
                              ),
                              Text(
                                isFavorite
                                    ? LocaleKeys.detailScreen.liked.tr()
                                    : LocaleKeys.detailScreen.like.tr(),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Text(
                        '${product.price}\$',
                        style: TextStyle(
                          fontSize: 18,
                          color: colors.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        LocaleKeys.detailScreen.description.tr(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        product.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: colors.onSurface,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
