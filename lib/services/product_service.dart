import 'package:exercise8_5_25/models/product.dart';

import "dio_client.dart";
import '../models/product_response.dart';

class ProductService {
  Future<ProductResponse> getProducts() async {
    final response = await DioClient.dio.get('/products');

    return ProductResponse.fromJson(response.data);
  }

  Future<Product> getProductById(int id) async {
    final response = await DioClient.dio.get('/products/$id');

    return Product.fromJson(response.data);
  }
}
