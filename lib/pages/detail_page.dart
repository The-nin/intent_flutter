import 'package:flutter/material.dart';
import 'package:exercise8_5_25/enums/ui_state.dart';
import 'package:exercise8_5_25/services/product_service.dart';
import '../models/product.dart';

class DetailPage extends StatefulWidget {
  final int productId;

  const DetailPage({super.key, required this.productId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  ProductService api = ProductService();
  UiState _state = UiState.initial;
  Product? _product;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    setState(() {
      _state = UiState.loading;
    });

    try {
      final result = await api.getProductById(widget.productId);

      if (!mounted) return;

      setState(() {
        _product = result;
        _state = UiState.success;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _state = UiState.error;
      });
    }
  }

  // void _toggleFavorite() {
  //   setState(() {
  //     _product!.isFavorite = !_product!.isFavorite;
  //     _product!.likeCount += _product!.isFavorite ? 1 : -1;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (_state == UiState.loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_state == UiState.error) {
      return Scaffold(
        appBar: AppBar(title: const Text('Chi tiết sản phẩm')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Không thể tải sản phẩm',
                style: TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: _loadProduct,
                child: const Text('Thử lại'),
              ),
            ],
          ),
        ),
      );
    }

    if (_state == UiState.empty || _product == null) {
      return const Scaffold(
        body: Center(child: Text('Không tìm thấy sản phẩm')),
      );
    }

    final product = _product!;

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
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                      // Column(
                      //   children: [
                      //     IconButton(
                      //       onPressed: _toggleFavorite,
                      //       icon: Icon(
                      //         product.isFavorite
                      //             ? Icons.favorite
                      //             : Icons.favorite_border,
                      //         color: product.isFavorite
                      //             ? Colors.red
                      //             : Colors.grey,
                      //         size: 28,
                      //       ),
                      //     ),

                      //     Text('${product.likeCount} lượt thích'),
                      //   ],
                      // ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '${product.price}\$',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Mô tả sản phẩm',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
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
  }
}
