import 'package:exercise_5_8_26/features/product/domain/usecases/get_favorite_product_ids_use_case.dart';
import 'package:exercise_5_8_26/features/product/domain/usecases/toggle_favorite_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:exercise_5_8_26/enums/ui_state.dart';
import 'package:exercise_5_8_26/features/product/domain/entities/product.dart';
import 'package:exercise_5_8_26/features/product/domain/usecases/get_product_by_id_use_case.dart';
import 'package:exercise_5_8_26/features/product/domain/usecases/get_products_use_case.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider({
    required GetProductsUseCase getProductsUseCase,
    required GetProductByIdUseCase getProductByIdUseCase,
    required ToggleFavoriteUseCase toggleFavoriteUseCase,
    required GetFavoriteProductIdsUseCase getFavoriteProductIdsUseCase,
  }) : _getProductsUseCase = getProductsUseCase,
       _getProductByIdUseCase = getProductByIdUseCase,
       _toggleFavoriteUseCase = toggleFavoriteUseCase,
       _getFavoriteProductIdsUseCase = getFavoriteProductIdsUseCase;

  final GetProductsUseCase _getProductsUseCase;
  final GetProductByIdUseCase _getProductByIdUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;
  final GetFavoriteProductIdsUseCase _getFavoriteProductIdsUseCase;

  UiStateEnum _productsState = UiStateEnum.initial;
  UiStateEnum _productDetailState = UiStateEnum.initial;

  List<Product> _products = [];
  Product? _product;

  String? _errorMessage;

  Set<String> _favoriteProductIds = {};

  UiStateEnum get productsState => _productsState;

  UiStateEnum get productDetailState => _productDetailState;

  List<Product> get products => _products;

  Product? get product => _product;

  String? get errorMessage => _errorMessage;

  bool isFavorite(int productId) {
    return _favoriteProductIds.contains(productId.toString());
  }

  Future<void> loadFavorites() async {
    _favoriteProductIds = (await _getFavoriteProductIdsUseCase())
        .map((id) => id.toString())
        .toSet();

    notifyListeners();
  }

  Future<void> getProducts() async {
    _productsState = UiStateEnum.loading;
    _errorMessage = null;

    notifyListeners();

    try {
      final products = await _getProductsUseCase();

      if (products.isEmpty) {
        _products = [];
        _productsState = UiStateEnum.empty;
      } else {
        _products = products;
        _productsState = UiStateEnum.success;
      }
    } catch (e) {
      _errorMessage = e.toString();
      _productsState = UiStateEnum.error;
    }

    notifyListeners();
  }

  Future<void> getProductById(int id) async {
    _productDetailState = UiStateEnum.loading;
    _errorMessage = null;
    _product = null;

    notifyListeners();

    try {
      final product = await _getProductByIdUseCase(id);

      _product = product;
      _productDetailState = UiStateEnum.success;
    } catch (e) {
      _errorMessage = e.toString();
      _productDetailState = UiStateEnum.error;
    }

    notifyListeners();
  }

  Future<void> toggleFavorite(int productId) async {
    await _toggleFavoriteUseCase(productId);

    final productIdString = productId.toString();

    if (_favoriteProductIds.contains(productIdString)) {
      _favoriteProductIds.remove(productIdString);
    } else {
      _favoriteProductIds.add(productIdString);
    }

    notifyListeners();
  }
}
