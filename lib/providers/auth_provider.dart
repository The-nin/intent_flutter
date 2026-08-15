import 'package:exercise_5_8_26/enums/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:exercise_5_8_26/models/login_response.dart';
import 'package:exercise_5_8_26/services/auth_service.dart';
import 'package:exercise_5_8_26/services/storage/local_storage_service.dart';

class AuthProvider extends ChangeNotifier {
  final LocalStorageService storage = LocalStorageService();
  final AuthService authService = AuthService();

  UiStateEnum _state = UiStateEnum.initial;

  String? _accessToken;
  String? _refreshToken;
  LoginResponse? _user;

  UiStateEnum get state => _state;

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  LoginResponse? get user => _user;

  Future<void> login(String username, String password) async {
    _state = UiStateEnum.loading;
    notifyListeners();

    try {
      final response = await authService.login(username, password);
      _accessToken = response.accessToken;
      _refreshToken = response.refreshToken;
      _user = response;

      await storage.saveAccessToken(response.accessToken);
      await storage.saveRefreshToken(response.refreshToken);

      _state = UiStateEnum.success;
      notifyListeners();
    } catch (e) {
      _state = UiStateEnum.error;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> loadToken() async {
    _accessToken = await storage.getAccessToken();
    _refreshToken = await storage.getRefreshToken();

    notifyListeners();
  }
}
