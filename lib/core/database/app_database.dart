import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static const _databaseName = 'shop_app.db';
  static const _databaseVersion = 1;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    _database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (database, version) async {
        await database.execute('''
          CREATE TABLE products (
            id INTEGER PRIMARY KEY,
            title TEXT NOT NULL,
            thumbnail TEXT NOT NULL,
            price REAL NOT NULL,
            description TEXT NOT NULL
          )
        ''');

        await database.execute('''
          CREATE TABLE favorite_products (
            product_id INTEGER PRIMARY KEY
          )
        ''');
      },
    );

    return _database!;
  }
}
