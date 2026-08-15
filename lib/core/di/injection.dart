import 'package:exercise_5_8_26/features/product/data/datasources/product_remote_datasource.dart';
import 'package:exercise_5_8_26/features/product/data/repositories/product_repository_impl.dart';
import 'package:exercise_5_8_26/features/product/domain/repositories/product_repository.dart';
import 'package:exercise_5_8_26/features/product/domain/usecases/get_product_by_id_use_case.dart';
import 'package:exercise_5_8_26/features/product/domain/usecases/get_products_use_case.dart';

class Injection {
  static final ProductRemoteDataSource productRemoteDataSource =
      ProductRemoteDataSource();

  static final ProductRepository productRepository = ProductRepositoryImpl(
    productRemoteDataSource,
  );

  static final GetProductsUseCase getProductsUseCase = GetProductsUseCase(
    productRepository,
  );

  static final GetProductByIdUseCase getProductByIdUseCase =
      GetProductByIdUseCase(productRepository);
}
