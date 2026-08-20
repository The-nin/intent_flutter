import 'package:exercise_5_8_26/enums/ui_state.dart';
import 'package:exercise_5_8_26/features/auth/domain/entities/auth_user.dart';
import 'package:exercise_5_8_26/features/auth/domain/usecases/login_use_case.dart';
import 'package:exercise_5_8_26/core/storage/secure_storage_service.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({
    required LoginUseCase loginUseCase,
    required SecureStorageService storage,
  }) : _loginUseCase = loginUseCase,
       _storage = storage;

  final LoginUseCase _loginUseCase;
  final SecureStorageService _storage;

  UiStateEnum _state = UiStateEnum.initial;

  String? _accessToken;
  String? _refreshToken;
  bool _isInitialized = false;
  AuthUser? _user;
  String? _errorMessage;

  UiStateEnum get state => _state;

  String? get accessToken => _accessToken;

  String? get refreshToken => _refreshToken;

  bool get isInitialized => _isInitialized;

  AuthUser? get user => _user;

  String? get errorMessage => _errorMessage;

  bool get isAuthenticated => _accessToken != null && _accessToken!.isNotEmpty;

  Future<void> login(String username, String password) async {
    _state = UiStateEnum.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = await _loginUseCase(username, password);

      _user = user;
      _accessToken = user.accessToken;
      _refreshToken = user.refreshToken;

      await _storage.saveAccessToken(user.accessToken);
      await _storage.saveRefreshToken(user.refreshToken);

      _state = UiStateEnum.success;
      notifyListeners();
    } catch (e) {
      _state = UiStateEnum.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadToken() async {
    _accessToken = await _storage.getAccessToken();
    _refreshToken = await _storage.getRefreshToken();

    _isInitialized = true;

    notifyListeners();
  }

  Future<void> logout() async {
    await _storage.clearTokens();

    _accessToken = null;
    _refreshToken = null;
    _user = null;

    notifyListeners();
  }
}
