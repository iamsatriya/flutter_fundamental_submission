import 'package:flutter/widgets.dart';
import 'package:new_fundamental_submission/data/api/utils.dart';
import 'package:new_fundamental_submission/data/model/restaurants.dart';

class RestaurantListItem extends StatelessWidget {
  final Restaurants restaurant;
  const RestaurantListItem({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(Utils.mediumImageUrl(restaurant.pictureId)),
        Text(restaurant.name),
      ],
    );
  }
}
