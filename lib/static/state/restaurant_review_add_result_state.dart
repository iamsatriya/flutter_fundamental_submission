import 'package:new_fundamental_submission/data/model/customer_review.dart';

sealed class RestaurantReviewAddResultState {}

class RestaurantReviewAddNoneState extends RestaurantReviewAddResultState {}

class RestaurantReviewAddLoadingState extends RestaurantReviewAddResultState {}

class RestaurantReviewAddErrorState extends RestaurantReviewAddResultState {
  final String error;

  RestaurantReviewAddErrorState(this.error);
}

class RestaurantReviewAddSuccessState extends RestaurantReviewAddResultState {
  final List<CustomerReview> data;

  RestaurantReviewAddSuccessState(this.data);
}
