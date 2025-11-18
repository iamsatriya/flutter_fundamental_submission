import 'package:flutter/material.dart';
import 'package:new_fundamental_submission/data/api/utils.dart';
import 'package:new_fundamental_submission/provider/main/local_database_provider.dart';
import 'package:new_fundamental_submission/static/navigation/navigation_route.dart';
import 'package:provider/provider.dart';

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
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Hero(
                                tag: Utils.smallImageUrl(restaurant.pictureId),
                                child: Image.network(
                                  width: 100,
                                  Utils.smallImageUrl(restaurant.pictureId),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              restaurant.name,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(restaurant.city),
                            trailing: Text(
                              restaurant.rating.toString(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
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
