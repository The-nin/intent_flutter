import 'package:exercise8_5_25/enums/ui_state.dart';
import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../services/storage/local_storage_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService productService = ProductService();
  final LocalStorageService storage = LocalStorageService();

  UiState _productsState = UiState.initial;
  UiState _productDetailState = UiState.initial;

  List<Product> _products = [];
  Product? _product;

  String? _errorMessage;

  Set<String> _favoriteProductIds = {};

  UiState get productsState => _productsState;
  UiState get productDetailState => _productDetailState;

  List<Product> get products => _products;
  Product? get product => _product;

  String? get errorMessage => _errorMessage;

  bool isFavorite(int productId) {
    return _favoriteProductIds.contains(productId.toString());
  }

  Future<void> loadFavorites() async {
    _favoriteProductIds = await storage.getFavoriteProductIds();

    notifyListeners();
  }

  Future<void> getProducts() async {
    _productsState = UiState.loading;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await productService.getProducts();

      if (response.products.isEmpty) {
        _products = [];
        _productsState = UiState.empty;
      } else {
        _products = response.products;
        _productsState = UiState.success;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _productsState = UiState.error;
    }
    notifyListeners();
  }

  Future<void> getProductById(int id) async {
    _productDetailState = UiState.loading;
    _errorMessage = null;
    _product = null;
    notifyListeners();

    try {
      final response = await productService.getProductById(id);

      _product = response;
      _productDetailState = UiState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _productDetailState = UiState.error;
    }

    notifyListeners();
  }

  Future<void> toggleFavorite(int productId) async {
    final productIdString = productId.toString();

    if (_favoriteProductIds.contains(productIdString)) {
      _favoriteProductIds.remove(productIdString);
    } else {
      _favoriteProductIds.add(productIdString);
    }

    await storage.saveFavoriteProductIds(_favoriteProductIds);

    notifyListeners();
  }
}
