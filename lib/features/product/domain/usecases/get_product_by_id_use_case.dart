import 'package:fpdart/fpdart.dart';
import 'package:exercise_5_8_26/core/error/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductByIdUseCase {
  final ProductRepository _repository;

  GetProductByIdUseCase(this._repository);

  Future<Either<Failure, Product>> call(int id) {
    return _repository.getProductById(id);
  }
}
