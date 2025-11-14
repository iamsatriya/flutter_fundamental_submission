import 'package:flutter/material.dart';
import 'package:new_fundamental_submission/provider/main/local_database_provider.dart';
import 'package:new_fundamental_submission/widget/favorite.dart';
import 'package:provider/provider.dart';
import 'package:new_fundamental_submission/static/navigation/navigation_route.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Favorite Restaurant',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Expanded(
                child: Consumer<LocalDatabaseProvider>(
                  builder: (context, value, child) {
                    if (value.favoriteRestaurantList == null) {
                      return const SizedBox();
                    }
                    final restaurantList = value.favoriteRestaurantList!;
                    return switch (restaurantList.length) {
                      0 => const Center(
                        child: Text('There are no favorite restaurant found.'),
                      ),
                      _ => ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemCount: restaurantList.length,
                        itemBuilder: (context, index) {
                          final restaurant = restaurantList[index];
                          return ListTile(
                            title: Text(restaurant.name),
                            subtitle: Text(restaurant.city),
                            trailing: Favorite(restaurant: restaurant),
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
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
