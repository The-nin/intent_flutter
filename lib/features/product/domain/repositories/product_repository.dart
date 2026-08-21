import '../entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();

  Future<Product> getProductById(int id);

  Future<List<Product>> getCachedProducts();

  Future<Product?> getCachedProductById(int id);

  Future<void> saveProducts(List<Product> products);

  Future<void> toggleFavorite(int productId);

  Future<Set<int>> getFavoriteProductIds();
}
