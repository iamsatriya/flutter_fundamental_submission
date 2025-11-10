import 'package:flutter/widgets.dart';
import 'package:new_fundamental_submission/data/api/api.dart';
import 'package:new_fundamental_submission/static/state/restaurant_detail_result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final Api _api;

  RestaurantDetailProvider(this._api);

  RestaurantDetailResultState _resultState = RestaurantDetailNoneState();

  RestaurantDetailResultState get resultState => _resultState;

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _resultState = RestaurantDetailLoadingState();
      notifyListeners();

      final result = await _api.getDetailRestaurant(id);

      if (result.error) {
        _resultState = RestaurantDetailErrorState(result.message);
      } else {
        _resultState = RestaurantDetailSuccessState(result.restaurant);
      }
    } on Exception catch (e) {
      _resultState = RestaurantDetailErrorState(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
