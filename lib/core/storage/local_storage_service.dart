import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String themeKey = 'theme_mode';

  static const String favProductsKey = 'fav_products';

  Future<void> saveThemeMode(String themeMode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(themeKey, themeMode);
  }

  Future<String?> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(themeKey);
  }

  Future<Set<String>> getFavoriteProductIds() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(favProductsKey)?.toSet() ?? {};
  }

  Future<void> saveFavoriteProductIds(Set<String> productIds) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(favProductsKey, productIds.toList());
  }
}
