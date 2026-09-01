import 'package:fpdart/fpdart.dart';
import 'package:exercise_5_8_26/core/error/failures.dart';
import 'package:exercise_5_8_26/features/product/domain/repositories/product_repository.dart';

class ToggleFavoriteUseCase {
  ToggleFavoriteUseCase(this._repository);

  final ProductRepository _repository;

  Future<Either<Failure, void>> call(int productId) {
    return _repository.toggleFavorite(productId);
  }
}
