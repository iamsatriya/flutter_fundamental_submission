import 'package:flutter/material.dart';
import 'package:new_fundamental_submission/data/model/restaurant.dart';

class DetailScreen extends StatelessWidget {
  final Restaurant restaurant;
  const DetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Detail Screen')));
  }
}
