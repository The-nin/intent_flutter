import "dio_client.dart";
import '../models/product_response.dart';

class ApiService {
  Future<ProductResponse> getProducts() async {
    try {
      final response = await DioClient.dio.get('/products');
      return ProductResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
