import 'package:new_fundamental_submission/data/model/restaurants.dart';
import 'package:new_fundamental_submission/data/response/response.dart';

class ListRestaurantResponse extends ResponseWithMessage {
  final int count;
  final List<Restaurants> restaurants;

  ListRestaurantResponse({
    required super.error,
    required super.message,
    required this.count,
    required this.restaurants,
  });

  factory ListRestaurantResponse.fromJson(Map<String, dynamic> json) {
    return ListRestaurantResponse(
      error: json['error'],
      message: json['message'],
      count: json['count'],
      restaurants: json['restaurants'] != null
          ? List<Restaurants>.from(
              json['restaurants']!.map((data) => Restaurants.fromJson(data)),
            )
          : <Restaurants>[],
    );
  }
}
