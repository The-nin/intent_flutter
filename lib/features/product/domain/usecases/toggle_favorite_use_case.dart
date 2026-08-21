import 'package:exercise_5_8_26/features/product/domain/repositories/product_repository.dart';

class ToggleFavoriteUseCase {
  ToggleFavoriteUseCase(this._repository);

  final ProductRepository _repository;

  Future<void> call(int productId) {
    return _repository.toggleFavorite(productId);
  }
}
