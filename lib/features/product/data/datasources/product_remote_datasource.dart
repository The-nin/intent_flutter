import 'package:dio/dio.dart';
import 'package:exercise_5_8_26/features/product/data/models/product_model.dart';
import 'package:exercise_5_8_26/features/product/data/models/product_response_model.dart';

class ProductRemoteDataSource {
  ProductRemoteDataSource({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Future<ProductResponseModel> getProducts() async {
    final response = await _dio.get('/products');

    return ProductResponseModel.fromJson(response.data);
  }

  Future<ProductModel> getProductById(int id) async {
    final response = await _dio.get('/products/$id');

    return ProductModel.fromJson(response.data);
  }
}
