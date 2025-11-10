import 'package:flutter/widgets.dart';
import 'package:new_fundamental_submission/data/api/api.dart';
import 'package:new_fundamental_submission/static/state/restaurant_review_add_result_state.dart';

class RestaurantReviewProvider extends ChangeNotifier {
  final Api _api;

  RestaurantReviewProvider(this._api);

  RestaurantReviewAddResultState _resultState = RestaurantReviewAddNoneState();

  RestaurantReviewAddResultState get resultState => _resultState;

  Future<void> addRestaurantReview(String id, String review) async {
    try {
      _resultState = RestaurantReviewAddLoadingState();
      notifyListeners();

      final result = await _api.postReviewRestaurant(
        id,
        'Food app user',
        review,
      );

      if (result.error) {
        _resultState = RestaurantReviewAddErrorState(result.message);
      } else {
        _resultState = RestaurantReviewAddSuccessState(result.customerReviews);
      }
    } on Exception catch (e) {
      _resultState = RestaurantReviewAddErrorState(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
