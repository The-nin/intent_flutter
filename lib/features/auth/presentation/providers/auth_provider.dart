import 'package:exercise_5_8_26/enums/ui_state.dart';
import 'package:exercise_5_8_26/features/auth/domain/entities/auth_user.dart';
import 'package:exercise_5_8_26/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:exercise_5_8_26/features/auth/domain/usecases/login_use_case.dart';
import 'package:exercise_5_8_26/core/storage/secure_storage_service.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({
    required LoginUseCase loginUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required SecureStorageService storage,
  }) : _loginUseCase = loginUseCase,
       _getCurrentUserUseCase = getCurrentUserUseCase,
       _storage = storage;

  final LoginUseCase _loginUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
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

  Future<bool> login(String username, String password) async {
    _state = UiStateEnum.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _loginUseCase(username.trim(), password.trim());

    return await result.fold(
      (failure) async {
        _state = UiStateEnum.error;
        _errorMessage = failure.message;
        notifyListeners();
        return false;
      },
      (user) async {
        _user = user;
        _accessToken = user.accessToken;
        _refreshToken = user.refreshToken;

        await _storage.saveAccessToken(user.accessToken);
        await _storage.saveRefreshToken(user.refreshToken);

        _state = UiStateEnum.success;
        notifyListeners();
        return true;
      },
    );
  }

  Future<void> initialize() async {
    _state = UiStateEnum.loading;
    notifyListeners();

    final accessToken = await _storage.getAccessToken();
    final refreshToken = await _storage.getRefreshToken();

    if (accessToken == null || accessToken.isEmpty) {
      _state = UiStateEnum.initial;
      _isInitialized = true;
      notifyListeners();
      return;
    }

    _accessToken = accessToken;
    _refreshToken = refreshToken;

    final result = await _getCurrentUserUseCase(
      accessToken: accessToken,
      refreshToken: refreshToken ?? '',
    );

    await result.fold(
      (failure) async {
        await _storage.clearTokens();

        _accessToken = null;
        _refreshToken = null;
        _user = null;

        _state = UiStateEnum.error;
        _errorMessage = failure.message;
      },
      (user) async {
        _user = user;
        _state = UiStateEnum.success;
      },
    );

    _isInitialized = true;
    notifyListeners();
  }

  void clearAuth() {
    _accessToken = null;
    _refreshToken = null;
    _user = null;
    _state = UiStateEnum.initial;
    _errorMessage = null;
    notifyListeners();
  }
}
