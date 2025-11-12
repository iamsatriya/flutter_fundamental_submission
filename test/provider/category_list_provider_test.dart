import 'package:mocktail/mocktail.dart';
import 'package:new_fundamental_submission/data/api/api.dart';
import 'package:new_fundamental_submission/provider/home/category_list_provider.dart';
import 'package:new_fundamental_submission/static/state/category_list_result_state.dart';
import 'package:test/test.dart';

class MockApi extends Mock implements Api {}

void main() {
  late MockApi api;
  late CategoryListProvider categoryListProvider;
  final List<String> successResult = ['italian'];

  setUp(() {
    api = MockApi();
    categoryListProvider = CategoryListProvider(api);
  });

  group('Category List Provider', () {
    test('should return result state of none', () {
      final state = categoryListProvider.resultState;

      expect(state, isA<CategoryListNoneState>());
    });

    test('should return restaurant list when API call succeed', () async {
      when(
        () => api.getListRestaurantCategory(),
      ).thenAnswer((invocation) async => successResult);

      await categoryListProvider.fetchCategoryList();

      final state =
          categoryListProvider.resultState as CategoryListSuccessState;

      expect(state.data.length, 1);
      expect(state.data.first, 'italian');

      verify(() => api.getListRestaurantCategory()).called(1);
    });

    test('should return empty list when API call failed', () async {
      when(
        () => api.getListRestaurantCategory(),
      ).thenAnswer((invocation) async => []);

      await categoryListProvider.fetchCategoryList();

      expect(categoryListProvider.resultState, isA<CategoryListErrorState>());
      final state = categoryListProvider.resultState as CategoryListErrorState;
      expect(state.error, contains('Category not found'));

      verify(() => api.getListRestaurantCategory()).called(1);
    });
  });
}
