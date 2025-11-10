import 'package:new_fundamental_submission/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  static const String _databaseName = 'foodapp.db';
  static const String _favoriteRestaurantTableName = 'favorite_restaurant';
  static const int _version = 1;

  Future<Database> _initializeDb() async {
    return openDatabase(
      _databaseName,
      version: _version,
      onCreate: (db, version) async {
        await createTables(db);
      },
    );
  }

  Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE $_favoriteRestaurantTableName(
        id TEXT PRIMARY KEY NOT NULL,
        name TEXT,
        description TEXT,
        city TEXT,
        address TEXT,
        picture_id TEXT,
        rating REAL,
        categories TEXT,
        menus TEXT,
        customer_reviews TEXT
      )
      """);
  }

  Future<void> insertFavoriteRestaurant(Restaurant restaurant) async {
    final db = await _initializeDb();

    final data = restaurant.toDatabase();

    await db.insert(
      _favoriteRestaurantTableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Restaurant>> getAllFavoriteRestaurant() async {
    final db = await _initializeDb();
    final results = await db.query(_favoriteRestaurantTableName);

    return results.map((result) => Restaurant.fromDatabase(result)).toList();
  }

  Future<Restaurant> getFavoriteRestaurantById(String id) async {
    final db = await _initializeDb();
    final results = await db.query(
      _favoriteRestaurantTableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return results.map((result) => Restaurant.fromDatabase(result)).first;
  }

  Future<void> removeFavoriteRestaurantById(String id) async {
    final db = await _initializeDb();
    await db.delete(
      _favoriteRestaurantTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
