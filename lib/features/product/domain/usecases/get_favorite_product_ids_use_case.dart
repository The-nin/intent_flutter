import 'package:exercise_5_8_26/features/product/domain/repositories/product_repository.dart';

class GetFavoriteProductIdsUseCase {
  GetFavoriteProductIdsUseCase(this._repository);

  final ProductRepository _repository;

  Future<Set<int>> call() {
    return _repository.getFavoriteProductIds();
  }
}
