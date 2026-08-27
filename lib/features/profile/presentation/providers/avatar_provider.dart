import 'dart:convert';

import 'package:exercise_5_8_26/core/storage/local_storage_service.dart';
import 'package:exercise_5_8_26/enums/ui_state.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class AvatarProvider extends ChangeNotifier {
  AvatarProvider({required LocalStorageService storage}) : _storage = storage;

  final ImagePicker _picker = ImagePicker();
  final LocalStorageService _storage;

  UiStateEnum _state = UiStateEnum.initial;
  Uint8List? _avatarBytes;
  String? _errorMessage;

  UiStateEnum get state => _state;
  Uint8List? get avatarBytes => _avatarBytes;
  String? get errorMessage => _errorMessage;

  Future<void> loadAvatar() async {
    try {
      final savedAvatar = await _storage.getAvatar();

      if (savedAvatar == null || savedAvatar.isEmpty) {
        return;
      }

      _avatarBytes = base64Decode(savedAvatar);
      _state = UiStateEnum.success;
      notifyListeners();
    } catch (_) {
      _state = UiStateEnum.error;
      _errorMessage = 'Không thể tải ảnh đại diện đã lưu.';
      notifyListeners();
    }
  }

  Future<void> pickAvatar(ImageSource source) async {
    _state = UiStateEnum.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final selectedFile = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (selectedFile == null) {
        _state = UiStateEnum.initial;
        notifyListeners();
        return;
      }

      final bytes = await selectedFile.readAsBytes();
      final fileSize = bytes.length;

      if (fileSize > 5 * 1024 * 1024) {
        _state = UiStateEnum.error;
        _errorMessage = 'Ảnh không được vượt quá 5 MB.';
        notifyListeners();
        return;
      }

      await _storage.saveAvatar(base64Encode(bytes));
      _avatarBytes = bytes;
      _state = UiStateEnum.success;
    } catch (e) {
      _state = UiStateEnum.error;
      _errorMessage = 'Không thể lưu ảnh đại diện. Vui lòng thử lại.';
    }

    notifyListeners();
  }
}
