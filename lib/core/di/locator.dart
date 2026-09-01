import 'package:get_it/get_it.dart';
import 'package:exercise_5_8_26/core/database/app_database.dart';
import 'package:exercise_5_8_26/core/network/dio_client.dart';
import 'package:exercise_5_8_26/core/storage/local_storage_service.dart';
import 'package:exercise_5_8_26/core/storage/secure_storage_service.dart';
import 'package:exercise_5_8_26/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:exercise_5_8_26/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:exercise_5_8_26/features/auth/domain/repositories/auth_repository.dart';
import 'package:exercise_5_8_26/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:exercise_5_8_26/features/auth/domain/usecases/login_use_case.dart';
import 'package:exercise_5_8_26/features/product/data/datasources/product_local_datasource.dart';
import 'package:exercise_5_8_26/features/product/data/datasources/product_remote_datasource.dart';
import 'package:exercise_5_8_26/features/product/data/repositories/product_repository_impl.dart';
import 'package:exercise_5_8_26/features/product/domain/repositories/product_repository.dart';
import 'package:exercise_5_8_26/features/product/domain/usecases/get_favorite_product_ids_use_case.dart';
import 'package:exercise_5_8_26/features/product/domain/usecases/get_favorite_products_use_case.dart';
import 'package:exercise_5_8_26/features/product/domain/usecases/get_product_by_id_use_case.dart';
import 'package:exercise_5_8_26/features/product/domain/usecases/get_products_use_case.dart';
import 'package:exercise_5_8_26/features/product/domain/usecases/toggle_favorite_use_case.dart';

final locator = GetIt.instance;

void setupLocator() {
  // Shared - Secure Services
  locator.registerLazySingleton<LocalStorageService>(
    () => LocalStorageService(),
  );
  locator.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(),
  );

  locator.registerLazySingleton<DioClient>(
    () => DioClient(storage: locator<SecureStorageService>()),
  );
  locator.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // Data Sources
  locator.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSource(dio: locator<DioClient>().dio),
  );
  locator.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSource(database: locator<AppDatabase>()),
  );
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(dio: locator<DioClient>().dio),
  );

  // Repositories
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      locator<ProductRemoteDataSource>(),
      locator<ProductLocalDataSource>(),
    ),
  );
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: locator<AuthRemoteDataSource>()),
  );

  // Use Cases
  locator.registerLazySingleton<GetProductsUseCase>(
    () => GetProductsUseCase(locator<ProductRepository>()),
  );
  locator.registerLazySingleton<GetProductByIdUseCase>(
    () => GetProductByIdUseCase(locator<ProductRepository>()),
  );
  locator.registerLazySingleton<ToggleFavoriteUseCase>(
    () => ToggleFavoriteUseCase(locator<ProductRepository>()),
  );
  locator.registerLazySingleton<GetFavoriteProductIdsUseCase>(
    () => GetFavoriteProductIdsUseCase(locator<ProductRepository>()),
  );
  locator.registerLazySingleton<GetFavoriteProductsUseCase>(
    () => GetFavoriteProductsUseCase(locator<ProductRepository>()),
  );

  locator.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(repository: locator<AuthRepository>()),
  );
  locator.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(repository: locator<AuthRepository>()),
  );
}
