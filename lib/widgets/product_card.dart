import 'package:flutter/material.dart';
import '../models/product.dart';
import '../pages/detail_page.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  // void _toggleFavorite() {
  //   setState(() {
  //     widget.product.isFavorite = !widget.product.isFavorite;
  //     widget.product.likeCount += widget.product.isFavorite ? 1 : -1;
  //   });
  // }

  Future<void> _openDetail() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailPage(productId: widget.product.id),
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return GestureDetector(
      onTap: _openDetail,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.network(
                  product.thumbnail,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${product.price}\$',
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: _toggleFavorite,
                      //   child: Row(
                      //     children: [
                      //       Icon(
                      //         product.isFavorite
                      //             ? Icons.favorite
                      //             : Icons.favorite_border,
                      //         color: product.isFavorite
                      //             ? Colors.red
                      //             : Colors.grey,
                      //         size: 18,
                      //       ),
                      //       const SizedBox(width: 2),
                      //       Text(
                      //         '${product.likeCount}',
                      //         style: const TextStyle(fontSize: 12),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
