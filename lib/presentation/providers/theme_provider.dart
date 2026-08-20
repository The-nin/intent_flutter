import 'package:flutter/material.dart';

import '../../core/storage/local_storage_service.dart';

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

  Future<void> toggleTheme() async {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;

      await _storage.saveThemeMode('dark');
    } else {
      _themeMode = ThemeMode.light;

      await _storage.saveThemeMode('light');
    }

    notifyListeners();
  }
}
