import 'package:new_fundamental_submission/data/model/restaurants.dart';

class SearchRestaurantResponse {
  final bool error;
  final int founded;
  final List<Restaurants> restaurants;

  SearchRestaurantResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchRestaurantResponse.fromJson(Map<String, dynamic> json) =>
      SearchRestaurantResponse(
        error: json['error'],
        founded: json['founded'],
        restaurants: List<Restaurants>.from(
          json['restaurants'].map((x) => Restaurants.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    'error': error,
    'founded': founded,
    'restaurants': List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}
