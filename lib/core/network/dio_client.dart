import 'package:dio/dio.dart';
import 'package:exercise_5_8_26/core/network/auth_interceptor.dart';
import 'package:exercise_5_8_26/core/storage/secure_storage_service.dart';
import 'package:flutter/foundation.dart';

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

    _dio.interceptors.add(
      AuthInterceptor(
        storage: storage,
        onSessionExpired: () {
          _onSessionExpired?.call();
        },
      ),
    );
  }

  late final Dio _dio;

  Dio get dio => _dio;

  VoidCallback? _onSessionExpired;

  void setOnSessionExpired(VoidCallback callback) {
    _onSessionExpired = callback;
  }
}
