import 'package:exercise_5_8_26/features/product/domain/entities/product.dart';
import 'package:exercise_5_8_26/features/product/domain/repositories/product_repository.dart';

class GetFavoriteProductsUseCase {
  GetFavoriteProductsUseCase(this._repository);

  final ProductRepository _repository;

  Future<List<Product>> call() {
    return _repository.getFavoriteProducts();
  }
}
