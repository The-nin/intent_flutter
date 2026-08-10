import 'package:flutter/material.dart';

import '../services/storage/local_storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  final LocalStorageService storage = LocalStorageService();

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  Future<void> loadTheme() async {
    final savedTheme = await storage.getThemeMode();

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

      await storage.saveThemeMode('dark');
    } else {
      _themeMode = ThemeMode.light;

      await storage.saveThemeMode('light');
    }

    notifyListeners();
  }
}