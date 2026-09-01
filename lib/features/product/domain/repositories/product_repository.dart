import 'package:fpdart/fpdart.dart';
import 'package:exercise_5_8_26/core/error/failures.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();

  Future<Either<Failure, Product>> getProductById(int id);

  Future<Either<Failure, List<Product>>> getCachedProducts();

  Future<Either<Failure, Product?>> getCachedProductById(int id);

  Future<Either<Failure, void>> saveProducts(List<Product> products);

  Future<Either<Failure, void>> toggleFavorite(int productId);

  Future<Either<Failure, Set<int>>> getFavoriteProductIds();

  Future<Either<Failure, List<Product>>> getFavoriteProducts();
}
