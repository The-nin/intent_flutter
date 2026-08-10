import 'package:flutter/material.dart';
import 'package:exercise8_5_25/services/storage/local_storage_service.dart';

class AuthProvider extends ChangeNotifier {
  final LocalStorageService storage = LocalStorageService();

  String? _token;

  String? get token => _token;

  Future<void> saveFakeToken() async {
    const fakeToken = 'fake_token_123456';

    await storage.saveToken(fakeToken);

    _token = fakeToken;

    notifyListeners();
  }

  Future<void> loadToken() async {
    _token = await storage.getToken();

    notifyListeners();
  }
}