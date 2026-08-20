import 'package:dio/dio.dart';
import 'package:exercise_5_8_26/core/network/auth_interceptor.dart';
import 'package:exercise_5_8_26/core/storage/secure_storage_service.dart';

class DioClient {
  DioClient({required SecureStorageService storage}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(AuthInterceptor(storage: storage));
  }

  late final Dio _dio;

  Dio get dio => _dio;
}
