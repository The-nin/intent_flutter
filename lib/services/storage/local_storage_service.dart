import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String themeKey = 'theme_mode';
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';

  Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(accessTokenKey, token);
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(accessTokenKey);
  }

  Future<void> saveRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(refreshTokenKey, token);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(refreshTokenKey);
  }

  Future<void> saveThemeMode(String themeMode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(themeKey, themeMode);
  }

  Future<String?> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(themeKey);
  }
}
