import 'package:exercise8_5_25/enums/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:exercise8_5_25/models/login_response.dart';
import 'package:exercise8_5_25/services/auth_service.dart';
import 'package:exercise8_5_25/services/storage/local_storage_service.dart';

class AuthProvider extends ChangeNotifier {
  final LocalStorageService storage = LocalStorageService();
  final AuthService authApi = AuthService();

  UiState _state = UiState.initial;

  String? _accessToken;
  String? _refreshToken;
  LoginResponse? _user;

  UiState get state => _state;

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  LoginResponse? get user => _user;

  Future<void> login(String username, String password) async {
    _state = UiState.loading;
    notifyListeners();

    try {
      final response = await authApi.login(username, password);
      _accessToken = response.accessToken;
      _refreshToken = response.refreshToken;
      _user = response;

      await storage.saveAccessToken(response.accessToken);
      await storage.saveRefreshToken(response.refreshToken);

      _state = UiState.success;
      notifyListeners();
    } catch (e) {
      _state = UiState.error;
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
