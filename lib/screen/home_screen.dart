import 'package:flutter/material.dart';
import 'package:new_fundamental_submission/static/navigation/navigation_route.dart';
import 'package:provider/provider.dart';
import 'package:new_fundamental_submission/provider/home/restaurant_list_provider.dart';
import 'package:new_fundamental_submission/static/state/restaurant_list_result_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('Restaurant List'),
            Expanded(
              child: Consumer<RestaurantListProvider>(
                builder: (context, value, child) {
                  return switch (value.resultState) {
                    RestaurantListSuccessState(:final data) =>
                      ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final restaurant = data[index];
                          return ListTile(
                            title: Text(restaurant.name),
                            subtitle: Text(restaurant.city),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                NavigationRoute.detail.name,
                                arguments: restaurant.id,
                              );
                            },
                          );
                        },
                      ),
                    RestaurantListLoadingState() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    RestaurantListErrorState(:final error) => Center(
                      child: Text(error),
                    ),
                    _ => const SizedBox(),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
