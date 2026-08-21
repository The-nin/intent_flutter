import 'package:exercise_5_8_26/core/database/app_database.dart';
import 'package:exercise_5_8_26/features/product/domain/entities/product.dart';
import 'package:sqflite/sqflite.dart';

class ProductLocalDataSource {
  ProductLocalDataSource({required AppDatabase database})
    : _database = database;

  final AppDatabase _database;

  Future<void> saveProducts(List<Product> products) async {
    final database = await _database.database;

    final batch = database.batch();

    for (final product in products) {
      batch.insert('products', {
        'id': product.id,
        'title': product.title,
        'thumbnail': product.thumbnail,
        'price': product.price,
        'description': product.description,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await batch.commit(noResult: true);
  }

  Future<List<Product>> getCachedProducts() async {
    final database = await _database.database;

    final rows = await database.query('products', orderBy: 'id ASC');

    return rows.map(_mapProduct).toList();
  }

  Future<Product?> getCachedProductById(int id) async {
    final database = await _database.database;

    final rows = await database.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (rows.isEmpty) {
      return null;
    }

    return _mapProduct(rows.first);
  }

  Future<void> toggleFavorite(int productId) async {
    final database = await _database.database;

    final existing = await database.query(
      'favorite_products',
      where: 'product_id = ?',
      whereArgs: [productId],
      limit: 1,
    );

    if (existing.isEmpty) {
      await database.insert('favorite_products', {'product_id': productId});
    } else {
      await database.delete(
        'favorite_products',
        where: 'product_id = ?',
        whereArgs: [productId],
      );
    }
  }

  Future<Set<int>> getFavoriteProductIds() async {
    final database = await _database.database;

    final rows = await database.query('favorite_products');

    return rows.map((row) => row['product_id'] as int).toSet();
  }

  Product _mapProduct(Map<String, Object?> row) {
    return Product(
      id: row['id'] as int,
      title: row['title'] as String,
      thumbnail: row['thumbnail'] as String,
      price: (row['price'] as num).toDouble(),
      description: row['description'] as String,
    );
  }
}
