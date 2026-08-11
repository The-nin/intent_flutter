import 'package:exercise8_5_25/enums/ui_state.dart';
import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService api = ProductService();

  UiState _state = UiState.initial;

  List<Product> _products = [];
  Product? _product;

  String? _errorMessage;

  UiState get state => _state;

  List<Product> get products => _products;
  Product? get product => _product;

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

  Future<void> getProductById(int id) async {
    _state = UiState.loading;
    _errorMessage = null;
    _product = null;
    notifyListeners();

    try {
      final response = await api.getProductById(id);

      _product = response;
      _state = UiState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = UiState.error;
    }
    notifyListeners();
  }
}
