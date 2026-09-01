import 'package:fpdart/fpdart.dart';
import 'package:exercise_5_8_26/core/error/failures.dart';
import 'package:exercise_5_8_26/features/product/domain/entities/product.dart';
import 'package:exercise_5_8_26/features/product/domain/repositories/product_repository.dart';

class GetFavoriteProductsUseCase {
  GetFavoriteProductsUseCase(this._repository);

  final ProductRepository _repository;

  Future<Either<Failure, List<Product>>> call() {
    return _repository.getFavoriteProducts();
  }
}
