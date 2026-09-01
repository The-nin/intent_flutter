import 'package:fpdart/fpdart.dart';
import 'package:exercise_5_8_26/core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository _repository;

  GetProductsUseCase(this._repository);

  Future<Either<Failure, List<Product>>> call() {
    return _repository.getProducts();
  }
}
