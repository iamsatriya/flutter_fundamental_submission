import 'package:flutter/widgets.dart';
import 'package:new_fundamental_submission/data/api/api.dart';
import 'package:new_fundamental_submission/static/state/category_list_result_state.dart';

class CategoryListProvider extends ChangeNotifier {
  final Api _api;

  CategoryListProvider(this._api);

  CategoryListResultState _resultState = CategoryListNoneState();

  CategoryListResultState get resultState => _resultState;

  Future<void> fetchCategoryList() async {
    try {
      _resultState = CategoryListLoadingState();
      notifyListeners();

      final result = await _api.getListRestaurantCategory();
      if (result.isEmpty) {
        _resultState = CategoryListErrorState('Category not found');
      } else {
        _resultState = CategoryListSuccessState(result);
      }
    } on Exception catch (e) {
      _resultState = CategoryListErrorState(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
