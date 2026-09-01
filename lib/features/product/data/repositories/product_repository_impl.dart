import 'package:fpdart/fpdart.dart';
import 'package:exercise_5_8_26/core/error/failures.dart';
import 'package:exercise_5_8_26/features/product/data/datasources/product_local_datasource.dart';
import 'package:exercise_5_8_26/features/product/data/datasources/product_remote_datasource.dart';
import 'package:exercise_5_8_26/features/product/domain/entities/product.dart';
import 'package:exercise_5_8_26/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._remoteDataSource, this._localDataSource);

  final ProductRemoteDataSource _remoteDataSource;
  final ProductLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final response = await _remoteDataSource.getProducts();

      final products = response.products
          .map((productModel) => productModel.toEntity())
          .toList();

      await _localDataSource.saveProducts(products);

      return Right(products);
    } catch (e) {
      try {
        final cachedProducts = await _localDataSource.getCachedProducts();
        if (cachedProducts.isEmpty) {
          return Left(ServerFailure(e.toString()));
        }
        return Right(cachedProducts);
      } catch (cacheError) {
        return Left(CacheFailure(cacheError.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(int id) async {
    try {
      final productModel = await _remoteDataSource.getProductById(id);
      final product = productModel.toEntity();

      await _localDataSource.saveProducts([product]);

      return Right(product);
    } catch (e) {
      try {
        final cachedProduct = await _localDataSource.getCachedProductById(id);
        if (cachedProduct == null) {
          return Left(ServerFailure(e.toString()));
        }
        return Right(cachedProduct);
      } catch (cacheError) {
        return Left(CacheFailure(cacheError.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getCachedProducts() async {
    try {
      final products = await _localDataSource.getCachedProducts();
      return Right(products);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product?>> getCachedProductById(int id) async {
    try {
      final product = await _localDataSource.getCachedProductById(id);
      return Right(product);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveProducts(List<Product> products) async {
    try {
      await _localDataSource.saveProducts(products);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(int productId) async {
    try {
      await _localDataSource.toggleFavorite(productId);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Set<int>>> getFavoriteProductIds() async {
    try {
      final ids = await _localDataSource.getFavoriteProductIds();
      return Right(ids);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getFavoriteProducts() async {
    try {
      final products = await _localDataSource.getFavoriteProducts();
      return Right(products);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
