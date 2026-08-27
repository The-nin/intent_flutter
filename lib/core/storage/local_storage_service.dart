import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String themeKey = 'theme_mode';
  static const String avatarKey = 'avatar_bytes';
  static const String languageKey = 'language_code';

  Future<void> saveThemeMode(String themeMode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(themeKey, themeMode);
  }

  Future<String?> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(themeKey);
  }

  Future<void> saveAvatar(String avatarBase64) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(avatarKey, avatarBase64);
  }

  Future<String?> getAvatar() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(avatarKey);
  }

  Future<void> saveLanguageCode(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(languageKey, languageCode);
  }

  Future<String?> getLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(languageKey);
  }
}
