import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String restaurantId;
  const DetailScreen({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Detail Screen of $restaurantId')),
    );
  }
}
