import 'package:exercise_5_8_26/core/storage/secure_storage_service.dart';
import 'package:exercise_5_8_26/enums/ui_state.dart';
import 'package:flutter/foundation.dart';

class LogoutProvider extends ChangeNotifier {
  LogoutProvider({
    required SecureStorageService storage,
    required VoidCallback onLoggedOut,
  }) : _storage = storage,
       _onLoggedOut = onLoggedOut;

  final SecureStorageService _storage;
  final VoidCallback _onLoggedOut;

  UiStateEnum _state = UiStateEnum.initial;
  String? _errorMessage;

  UiStateEnum get state => _state;
  String? get errorMessage => _errorMessage;

  Future<bool> logout() async {
    if (_state == UiStateEnum.loading) {
      return false;
    }

    _state = UiStateEnum.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await _storage.clearTokens();
      _onLoggedOut();
      _state = UiStateEnum.success;
      return true;
    } catch (e) {
      _state = UiStateEnum.error;
      _errorMessage = e.toString();
      return false;
    } finally {
      notifyListeners();
    }
  }
}
