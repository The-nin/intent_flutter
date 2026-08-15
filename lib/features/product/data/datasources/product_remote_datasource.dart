import 'package:exercise_5_8_26/core/network/dio_client.dart';
import 'package:exercise_5_8_26/features/product/data/models/product_model.dart';
import 'package:exercise_5_8_26/features/product/data/models/product_response_model.dart';

class ProductRemoteDataSource {
  Future<ProductResponseModel> getProducts() async {
    final response = await DioClient.dio.get('/products');

    return ProductResponseModel.fromJson(response.data);
  }

  Future<ProductModel> getProductById(int id) async {
    final response = await DioClient.dio.get('/products/$id');

    return ProductModel.fromJson(response.data);
  }
}
