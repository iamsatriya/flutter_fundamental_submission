import 'package:flutter/material.dart';
import 'package:new_fundamental_submission/data/api/utils.dart';
import 'package:new_fundamental_submission/data/model/restaurant.dart';
import 'package:new_fundamental_submission/widget/favorite.dart';
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
              RestaurantDetailSuccessState(:final data) => CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                        tag: Utils.largeImageUrl(data.pictureId),
                        child: Image.network(
                          Utils.largeImageUrl(data.pictureId),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    leading: IconButton(
                      icon: Icon(Icons.chevron_left),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.onPrimary.withAlpha(70),
                        ),
                        iconColor: WidgetStatePropertyAll(Colors.black),
                      ),
                    ),
                    actions: [Favorite(restaurant: data)],
                    expandedHeight: 250,
                  ),
                  SliverToBoxAdapter(child: DetailContent(data: data)),
                ],
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

class DetailContent extends StatelessWidget {
  const DetailContent({super.key, required this.data});

  final Restaurant data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            data.name,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),
          Text(
            'Restaurant located in ${data.city}, Indonesia',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 4),
          Text(
            '${data.menus.foods.length} foods • ${data.menus.drinks.length} drinks',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      data.rating.toString(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, size: 12),
                        Icon(Icons.star, size: 12),
                        Icon(Icons.star, size: 12),
                        Icon(Icons.star, size: 12),
                        Icon(Icons.star, size: 12),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: Theme.of(context).dividerColor,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      data.customerReviews.length.toString(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Reviews'),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: Theme.of(context).dividerColor,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${data.menus.drinks.length + data.menus.foods.length}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Menu'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: Theme.of(context).dividerColor),
          const SizedBox(height: 16),
          Text(data.description),
        ],
      ),
    );
  }
}
