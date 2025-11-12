import 'package:mocktail/mocktail.dart';
import 'package:new_fundamental_submission/data/api/api.dart';
import 'package:new_fundamental_submission/data/model/restaurants.dart';
import 'package:new_fundamental_submission/data/response/list_restaurant_response.dart';
import 'package:new_fundamental_submission/provider/home/restaurant_list_provider.dart';
import 'package:new_fundamental_submission/static/state/restaurant_list_result_state.dart';
import 'package:test/test.dart';

class MockApi extends Mock implements Api {}

void main() {
  late MockApi api;
  late RestaurantListProvider restaurantListProvider;
  final ListRestaurantResponse successResult = ListRestaurantResponse(
    error: false,
    message: 'success',
    count: 1,
    restaurants: [
      Restaurants(
        id: '1',
        city: 'city',
        name: 'name',
        description: 'description',
        pictureId: '1',
        rating: 5.0,
      ),
    ],
  );

  setUp(() {
    api = MockApi();
    restaurantListProvider = RestaurantListProvider(api);
  });

  group('Restaurant List Provider', () {
    test('should return result state of none', () {
      final state = restaurantListProvider.resultState;

      expect(state, isA<RestaurantListNoneState>());
    });

    test('should return restaurant list when API call succeed', () async {
      when(
        () => api.getListRestaurant(),
      ).thenAnswer((invocation) async => successResult);

      await restaurantListProvider.fetchRestaurantList();

      final state =
          restaurantListProvider.resultState as RestaurantListSuccessState;

      expect(state.data.length, 1);
      expect(state.data.first.name, 'name');

      verify(() => api.getListRestaurant()).called(1);
    });

    test('should throw Exception when API call failed', () async {
      when(
        () => api.getListRestaurant(),
      ).thenThrow(Exception('Failed to fetch restaurant list'));

      await restaurantListProvider.fetchRestaurantList();

      expect(
        restaurantListProvider.resultState,
        isA<RestaurantListErrorState>(),
      );

      final state =
          restaurantListProvider.resultState as RestaurantListErrorState;
      expect(state.error, contains('Failed to fetch restaurant list'));

      verify(() => api.getListRestaurant()).called(1);
    });
  });
}
