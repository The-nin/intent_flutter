import 'package:dio/dio.dart';
import 'package:exercise_5_8_26/core/network/auth_interceptor.dart';
import 'package:exercise_5_8_26/core/storage/secure_storage_service.dart';

class DioClient {
  static final SecureStorageService _storage = SecureStorageService();

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {'Content-Type': 'application/json'},
    ),
  )..interceptors.add(AuthInterceptor(storage: _storage));
}
