import 'package:flutter/material.dart';

import '../storage/local_storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider({required LocalStorageService storage}) : _storage = storage;

  final LocalStorageService _storage;

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  Future<void> loadTheme() async {
    final savedTheme = await _storage.getThemeMode();

    if (savedTheme == 'dark') {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }

    notifyListeners();
  }

  Future<void> changeTheme(ThemeMode themeMode) async {
    if (_themeMode == themeMode) {
      return;
    }

    _themeMode = themeMode;

    await _storage.saveThemeMode(
      themeMode == ThemeMode.dark ? 'dark' : 'light',
    );

    notifyListeners();
  }
}
