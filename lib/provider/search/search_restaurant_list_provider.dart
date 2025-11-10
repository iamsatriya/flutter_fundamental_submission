import 'package:flutter/widgets.dart';
import 'package:new_fundamental_submission/data/api/api.dart';
import 'package:new_fundamental_submission/static/state/restaurant_list_result_state.dart';

class SearchRestaurantListProvider extends ChangeNotifier {
  final Api _api;

  SearchRestaurantListProvider(this._api);

  RestaurantListResultState _resultState = RestaurantListNoneState();

  RestaurantListResultState get resultState => _resultState;

  Future<void> fetchSearchRestaurantList(String query) async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();

      final result = await _api.getSearchRestaurant(query);

      if (result.error) {
        _resultState = RestaurantListErrorState('Restaurant Not Found');
      } else {
        _resultState = RestaurantListSuccessState(result.restaurants);
      }
    } on Exception catch (e) {
      _resultState = RestaurantListErrorState(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
