import 'package:exercise_5_8_26/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:exercise_5_8_26/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:exercise_5_8_26/features/auth/domain/repositories/auth_repository.dart';
import 'package:exercise_5_8_26/features/auth/domain/usecases/login_use_case.dart';
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

  static final AuthRemoteDataSource authRemoteDataSource =
      AuthRemoteDataSource();

  static final AuthRepository authRepository = AuthRepositoryImpl(
    remoteDataSource: authRemoteDataSource,
  );

  static final LoginUseCase loginUseCase = LoginUseCase(
    repository: authRepository,
  );
}
