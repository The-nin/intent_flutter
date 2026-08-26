import 'package:exercise_5_8_26/features/product/data/datasources/product_local_datasource.dart';
import 'package:exercise_5_8_26/features/product/data/datasources/product_remote_datasource.dart';
import 'package:exercise_5_8_26/features/product/domain/entities/product.dart';
import 'package:exercise_5_8_26/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._remoteDataSource, this._localDataSource);

  final ProductRemoteDataSource _remoteDataSource;
  final ProductLocalDataSource _localDataSource;

  @override
  Future<List<Product>> getProducts() async {
    try {
      final response = await _remoteDataSource.getProducts();

      final products = response.products
          .map((productModel) => productModel.toEntity())
          .toList();

      await _localDataSource.saveProducts(products);

      return products;
    } catch (_) {
      final cachedProducts = await _localDataSource.getCachedProducts();

      if (cachedProducts.isEmpty) {
        rethrow;
      }

      return cachedProducts;
    }
  }

  @override
  Future<Product> getProductById(int id) async {
    try {
      final productModel = await _remoteDataSource.getProductById(id);
      final product = productModel.toEntity();

      await _localDataSource.saveProducts([product]);

      return product;
    } catch (_) {
      final cachedProduct = await _localDataSource.getCachedProductById(id);

      if (cachedProduct == null) {
        rethrow;
      }

      return cachedProduct;
    }
  }

  @override
  Future<List<Product>> getCachedProducts() {
    return _localDataSource.getCachedProducts();
  }

  @override
  Future<Product?> getCachedProductById(int id) {
    return _localDataSource.getCachedProductById(id);
  }

  @override
  Future<void> saveProducts(List<Product> products) {
    return _localDataSource.saveProducts(products);
  }

  @override
  Future<void> toggleFavorite(int productId) {
    return _localDataSource.toggleFavorite(productId);
  }

  @override
  Future<Set<int>> getFavoriteProductIds() {
    return _localDataSource.getFavoriteProductIds();
  }

  @override
  Future<List<Product>> getFavoriteProducts() {
    return _localDataSource.getFavoriteProducts();
  }
}
