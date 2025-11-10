import 'package:flutter/widgets.dart';
import 'package:new_fundamental_submission/data/api/api.dart';
import 'package:new_fundamental_submission/static/state/restaurant_list_result_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final Api _api;

  RestaurantListProvider(this._api);

  RestaurantListResultState _resultState = RestaurantListNoneState();

  RestaurantListResultState get resultState => _resultState;

  Future fetchRestaurantList() async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();

      final result = await _api.getListRestaurant();

      if (result.error) {
        _resultState = RestaurantListErrorState(result.message);
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
