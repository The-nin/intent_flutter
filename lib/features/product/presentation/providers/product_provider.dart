import 'package:exercise_5_8_26/features/product/domain/usecases/get_favorite_product_ids_use_case.dart';
import 'package:exercise_5_8_26/features/product/domain/usecases/get_favorite_products_use_case.dart';
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
    required GetFavoriteProductsUseCase getFavoriteProductsUseCase,
  }) : _getProductsUseCase = getProductsUseCase,
       _getProductByIdUseCase = getProductByIdUseCase,
       _toggleFavoriteUseCase = toggleFavoriteUseCase,
       _getFavoriteProductIdsUseCase = getFavoriteProductIdsUseCase,
       _getFavoriteProductsUseCase = getFavoriteProductsUseCase;

  final GetProductsUseCase _getProductsUseCase;
  final GetProductByIdUseCase _getProductByIdUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;
  final GetFavoriteProductIdsUseCase _getFavoriteProductIdsUseCase;
  final GetFavoriteProductsUseCase _getFavoriteProductsUseCase;

  UiStateEnum _productsState = UiStateEnum.initial;
  UiStateEnum _productDetailState = UiStateEnum.initial;
  UiStateEnum _favoriteProductsState = UiStateEnum.initial;

  List<Product> _products = [];
  Product? _product;

  String? _errorMessage;

  Set<String> _favoriteProductIds = {};

  List<Product> _favoriteProducts = [];

  UiStateEnum get productsState => _productsState;

  UiStateEnum get productDetailState => _productDetailState;

  List<Product> get products => _products;

  Product? get product => _product;

  String? get errorMessage => _errorMessage;

  List<Product> get favoriteProducts => _favoriteProducts;

  UiStateEnum get favoriteProductsState => _favoriteProductsState;

  bool isFavorite(int productId) {
    return _favoriteProductIds.contains(productId.toString());
  }

  Future<void> loadFavorites() async {
    _favoriteProductsState = UiStateEnum.loading;
    notifyListeners();

    final idsResult = await _getFavoriteProductIdsUseCase();
    final productsResult = await _getFavoriteProductsUseCase();

    idsResult.fold(
      (failure) {
        _favoriteProductsState = UiStateEnum.error;
        _errorMessage = failure.message;
      },
      (ids) {
        _favoriteProductIds = ids.map((id) => id.toString()).toSet();
      },
    );

    productsResult.fold(
      (failure) {
        _favoriteProductsState = UiStateEnum.error;
        _errorMessage = failure.message;
      },
      (products) {
        _favoriteProducts = products;
        if (_favoriteProductsState != UiStateEnum.error) {
          _favoriteProductsState = UiStateEnum.success;
        }
      },
    );

    notifyListeners();
  }

  Future<void> getProducts() async {
    _productsState = UiStateEnum.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _getProductsUseCase();

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _productsState = UiStateEnum.error;
      },
      (products) {
        if (products.isEmpty) {
          _products = [];
          _productsState = UiStateEnum.empty;
        } else {
          _products = products;
          _productsState = UiStateEnum.success;
        }
      },
    );

    notifyListeners();
  }

  Future<void> getProductById(int id) async {
    _productDetailState = UiStateEnum.loading;
    _errorMessage = null;
    _product = null;
    notifyListeners();

    final result = await _getProductByIdUseCase(id);

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _productDetailState = UiStateEnum.error;
      },
      (product) {
        _product = product;
        _productDetailState = UiStateEnum.success;
      },
    );

    notifyListeners();
  }

  Future<void> toggleFavorite(int productId) async {
    final result = await _toggleFavoriteUseCase(productId);

    await result.fold(
      (failure) async {
        _errorMessage = failure.message;
        notifyListeners();
      },
      (_) async {
        final idsResult = await _getFavoriteProductIdsUseCase();
        idsResult.fold(
          (failure) {
            _errorMessage = failure.message;
          },
          (ids) {
            _favoriteProductIds = ids.map((id) => id.toString()).toSet();
          }
        );

        final productsResult = await _getFavoriteProductsUseCase();
        productsResult.fold(
          (failure) {
            _errorMessage = failure.message;
          },
          (products) {
            _favoriteProducts = products;
          }
        );

        notifyListeners();
      },
    );
  }
}
