import 'package:exercise_5_8_26/features/product/data/datasources/product_remote_datasource.dart';
import 'package:exercise_5_8_26/features/product/domain/entities/product.dart';
import 'package:exercise_5_8_26/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._remoteDataSource);

  final ProductRemoteDataSource _remoteDataSource;

  @override
  Future<List<Product>> getProducts() async {
    final response = await _remoteDataSource.getProducts();

    return response.products
        .map((productModel) => productModel.toEntity())
        .toList();
  }

  @override
  Future<Product> getProductById(int id) async {
    final productModel = await _remoteDataSource.getProductById(id);

    return productModel.toEntity();
  }
}
