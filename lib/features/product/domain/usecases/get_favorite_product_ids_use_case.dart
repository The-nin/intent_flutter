import 'package:fpdart/fpdart.dart';
import 'package:exercise_5_8_26/core/error/failures.dart';
import 'package:exercise_5_8_26/features/product/domain/repositories/product_repository.dart';

class GetFavoriteProductIdsUseCase {
  GetFavoriteProductIdsUseCase(this._repository);

  final ProductRepository _repository;

  Future<Either<Failure, Set<int>>> call() {
    return _repository.getFavoriteProductIds();
  }
}
