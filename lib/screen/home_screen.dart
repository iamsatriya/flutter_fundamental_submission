import 'package:flutter/material.dart';
import 'package:new_fundamental_submission/data/api/utils.dart';
import 'package:new_fundamental_submission/provider/home/category_list_provider.dart';
import 'package:new_fundamental_submission/static/navigation/navigation_route.dart';
import 'package:new_fundamental_submission/static/state/category_list_result_state.dart';
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
      context.read<CategoryListProvider>().fetchCategoryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    const double horizontalSpacing = 16.0;
    return Scaffold(
      appBar: AppBar(
        title: FilledButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.search), Text('Start your search')],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalSpacing,
              ),
              child: Text(
                'Popular category',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 90,
              child: Consumer<CategoryListProvider>(
                builder: (context, value, child) {
                  return switch (value.resultState) {
                    CategoryListSuccessState(:final data) => ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 4),
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length + 2,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return const SizedBox(width: horizontalSpacing);
                        } else if (index == data.length + 1) {
                          return const SizedBox(width: horizontalSpacing);
                        }

                        final category = data[index - 1];
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withAlpha(75),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                category,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    CategoryListErrorState(:final error) => Center(
                      child: Text(error),
                    ),
                    CategoryListLoadingState() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    _ => const SizedBox(),
                  };
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalSpacing,
                ),
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
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Hero(
                                  tag: Utils.smallImageUrl(
                                    restaurant.pictureId,
                                  ),
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
            ),
          ],
        ),
      ),
    );
  }
}
