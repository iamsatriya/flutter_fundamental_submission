import 'package:new_fundamental_submission/data/model/restaurant.dart';
import 'package:new_fundamental_submission/data/response/response.dart';

class DetailRestaurantResponse extends ResponseWithMessage {
  final Restaurant restaurant;

  DetailRestaurantResponse({
    required super.error,
    required super.message,
    required this.restaurant,
  });

  factory DetailRestaurantResponse.fromJson(Map<String, dynamic> json) {
    return DetailRestaurantResponse(
      error: json['error'],
      message: json['message'],
      restaurant: Restaurant.fromJson(json['restaurant']),
    );
  }
}
