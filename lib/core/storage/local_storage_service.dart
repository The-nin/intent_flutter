import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String themeKey = 'theme_mode';

  Future<void> saveThemeMode(String themeMode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(themeKey, themeMode);
  }

  Future<String?> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(themeKey);
  }
}
