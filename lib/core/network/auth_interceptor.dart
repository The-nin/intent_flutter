import 'package:dio/dio.dart';
import 'package:exercise_5_8_26/core/storage/secure_storage_service.dart';

class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({
    required SecureStorageService storage,
    required void Function() onSessionExpired,
  }) : _storage = storage,
       _onSessionExpired = onSessionExpired;

  final SecureStorageService _storage;
  final void Function() _onSessionExpired;

  final Dio _refreshDio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<bool>? _refreshFuture;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _storage.getAccessToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final response = err.response;

    // Không phải 401 → để Dio xử lý bình thường.
    if (response?.statusCode != 401) {
      handler.next(err);
      return;
    }

    final requestOptions = err.requestOptions;

    final hasRetried = requestOptions.extra['retried'] == true;

    if (hasRetried) {
      await _clearSession();
      handler.next(err);
      return;
    }

    try {
      final refreshSuccess = await _refreshAccessToken();

      if (!refreshSuccess) {
        await _clearSession();
        handler.next(err);
        return;
      }

      final newAccessToken = await _storage.getAccessToken();

      if (newAccessToken == null || newAccessToken.isEmpty) {
        await _clearSession();
        handler.next(err);
        return;
      }

      requestOptions.extra['retried'] = true;

      requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

      final response = await _refreshDio.fetch(requestOptions);

      handler.resolve(response);
    } catch (_) {
      await _clearSession();
      handler.next(err);
    }
  }

  Future<bool> _refreshAccessToken() async {
    final currentRefresh = _refreshFuture;

    if (currentRefresh != null) {
      return currentRefresh;
    }

    _refreshFuture = _performRefresh();

    try {
      return await _refreshFuture!;
    } finally {
      _refreshFuture = null;
    }
  }

  Future<bool> _performRefresh() async {
    final refreshToken = await _storage.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      return false;
    }

    try {
      final response = await _refreshDio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken, 'expiresInMins': 30},
      );

      final data = response.data;

      final newAccessToken = data['accessToken'];
      final newRefreshToken = data['refreshToken'];

      if (newAccessToken == null ||
          newRefreshToken == null ||
          newAccessToken is! String ||
          newRefreshToken is! String) {
        return false;
      }

      await _storage.saveAccessToken(newAccessToken);
      await _storage.saveRefreshToken(newRefreshToken);

      return true;
    } on DioException {
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<void> _clearSession() async {
    await _storage.clearTokens();
    _onSessionExpired();
  }
}
