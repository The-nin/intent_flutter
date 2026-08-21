import 'package:exercise_5_8_26/core/database/app_database.dart';
import 'package:exercise_5_8_26/core/network/dio_client.dart';
import 'package:exercise_5_8_26/core/storage/local_storage_service.dart';
import 'package:exercise_5_8_26/core/storage/secure_storage_service.dart';
import 'package:exercise_5_8_26/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:exercise_5_8_26/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:exercise_5_8_26/features/auth/domain/repositories/auth_repository.dart';
import 'package:exercise_5_8_26/features/auth/domain/usecases/login_use_case.dart';
import 'package:exercise_5_8_26/features/product/data/datasources/product_local_datasource.dart';
import 'package:exercise_5_8_26/features/product/data/datasources/product_remote_datasource.dart';
import 'package:exercise_5_8_26/features/product/data/repositories/product_repository_impl.dart';
import 'package:exercise_5_8_26/features/product/domain/repositories/product_repository.dart';
import 'package:exercise_5_8_26/features/product/domain/usecases/get_favorite_product_ids_use_case.dart';
import 'package:exercise_5_8_26/features/product/domain/usecases/get_product_by_id_use_case.dart';
import 'package:exercise_5_8_26/features/product/domain/usecases/get_products_use_case.dart';
import 'package:exercise_5_8_26/features/product/domain/usecases/toggle_favorite_use_case.dart';

class Injection {
  static final DioClient dioClient = DioClient(storage: secureStorageService);
  //*
  //Shared - Secure Services
  //**
  static final LocalStorageService localStorageService = LocalStorageService();

  static final SecureStorageService secureStorageService =
      SecureStorageService();

  //*
  //Product Features
  //**
  static final ProductRemoteDataSource productRemoteDataSource =
      ProductRemoteDataSource(dio: dioClient.dio);

  static final ProductRepository productRepository = ProductRepositoryImpl(
    productRemoteDataSource,
    productLocalDataSource,
  );

  static final GetProductsUseCase getProductsUseCase = GetProductsUseCase(
    productRepository,
  );

  static final GetProductByIdUseCase getProductByIdUseCase =
      GetProductByIdUseCase(productRepository);

  //*
  //Auth Features
  //**
  static final AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource(
    dio: dioClient.dio,
  );

  static final AuthRepository authRepository = AuthRepositoryImpl(
    remoteDataSource: authRemoteDataSource,
  );

  static final LoginUseCase loginUseCase = LoginUseCase(
    repository: authRepository,
  );

  static final AppDatabase appDatabase = AppDatabase();

  static final ProductLocalDataSource productLocalDataSource =
      ProductLocalDataSource(database: appDatabase);

  static final ToggleFavoriteUseCase toggleFavoriteUseCase =
      ToggleFavoriteUseCase(productRepository);

  static final GetFavoriteProductIdsUseCase getFavoriteProductIdsUseCase =
      GetFavoriteProductIdsUseCase(productRepository);
}
