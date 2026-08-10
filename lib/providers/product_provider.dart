import 'package:exercise8_5_25/enums/ui_state.dart';
import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService api = ApiService();

  UiState _state = UiState.initial;

  List<Product> _products = [];

  String? _errorMessage;

  UiState get state => _state;

  List<Product> get products => _products;

  String? get errorMessage => _errorMessage;

  Future<void> getProducts() async {
    _state = UiState.loading;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await api.getProducts();

      if (response.products.isEmpty) {
        _products = [];
        _state = UiState.empty;
      } else {
        _products = response.products;
        _state = UiState.success;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _state = UiState.error;
    }
    notifyListeners();
  }
}
