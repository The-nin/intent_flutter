import 'package:flutter/material.dart';

import '../storage/local_storage_service.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider({required LocalStorageService storage}) : _storage = storage;

  final LocalStorageService _storage;

  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  Future<void> loadLocale() async {
    final languageCode = await _storage.getLanguageCode();

    if (languageCode != null) {
      _locale = Locale(languageCode);
    }

    notifyListeners();
  }

  Future<void> changeLocale(String languageCode) async {
    if (_locale.languageCode == languageCode) {
      return;
    }

    _locale = Locale(languageCode);

    await _storage.saveLanguageCode(languageCode);

    notifyListeners();
  }
}
