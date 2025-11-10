import 'package:new_fundamental_submission/data/model/restaurant.dart';

sealed class RestaurantDetailResultState {}

class RestaurantDetailNoneState extends RestaurantDetailResultState {}

class RestaurantDetailLoadingState extends RestaurantDetailResultState {}

class RestaurantDetailErrorState extends RestaurantDetailResultState {
  final String error;

  RestaurantDetailErrorState(this.error);
}

class RestaurantDetailSuccessState extends RestaurantDetailResultState {
  final Restaurant data;

  RestaurantDetailSuccessState(this.data);
}
