import 'package:flutter/widgets.dart';
import 'package:new_fundamental_submission/data/model/restaurant.dart';
import 'package:new_fundamental_submission/service/sqlite_service.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  final SqliteService _service;

  LocalDatabaseProvider(this._service);

  String _message = "";
  String get message => _message;

  List<Restaurant>? _favoriteRestaurantList;
  List<Restaurant>? get favoriteRestaurantList => _favoriteRestaurantList;

  Restaurant? _favoriteRestaurant;
  Restaurant? get favoriteRestaurant => _favoriteRestaurant;

  Future<void> addFavoriteRestaurant(Restaurant restaurant) async {
    try {
      await _service.insertFavoriteRestaurant(restaurant);
      _message = "Success to add favorite restaurant";
    } catch (e) {
      _message = "Failed to add favorite restaurant";
    } finally {
      notifyListeners();
    }
  }

  Future<void> getAllFavoriteRestaurant() async {
    try {
      _favoriteRestaurantList = await _service.getAllFavoriteRestaurant();
      _message = "Success load all favorite restaurant";
    } catch (e) {
      _message = "Failed to load all favorite restaurant";
    } finally {
      notifyListeners();
    }
  }

  Future<void> getFavoriteRestaurantById(String id) async {
    try {
      _favoriteRestaurant = await _service.getFavoriteRestaurantById(id);
      _message = "Success to load favorite restaurant";
    } catch (e) {
      _message = "Failed to load favorite restaurant";
    } finally {
      notifyListeners();
    }
  }

  Future<void> removeFavoriteRestaurantById(String id) async {
    try {
      await _service.removeFavoriteRestaurantById(id);
      _message = "Success to remove favorite restaurant";
    } catch (e) {
      _message = "Failed to remove favorite restaurant";
    } finally {
      notifyListeners();
    }
  }
}
