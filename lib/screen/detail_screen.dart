import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:new_fundamental_submission/provider/detail/restaurant_detail_provider.dart';
import 'package:new_fundamental_submission/static/state/restaurant_detail_result_state.dart';

class DetailScreen extends StatefulWidget {
  final String restaurantId;
  const DetailScreen({super.key, required this.restaurantId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<RestaurantDetailProvider>().fetchRestaurantDetail(
        widget.restaurantId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<RestaurantDetailProvider>(
          builder: (context, value, child) {
            return switch (value.resultState) {
              RestaurantDetailSuccessState(:final data) => Column(
                children: [Text(data.name), Text(data.description)],
              ),
              RestaurantDetailErrorState(:final error) => Center(
                child: Text(error),
              ),
              RestaurantDetailLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    );
  }
}
