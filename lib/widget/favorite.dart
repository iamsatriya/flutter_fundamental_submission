import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:new_fundamental_submission/data/model/restaurant.dart';
import 'package:new_fundamental_submission/provider/detail/bookmark_icon_provider.dart';
import 'package:new_fundamental_submission/provider/main/local_database_provider.dart';

class Favorite extends StatefulWidget {
  final Restaurant restaurant;
  const Favorite({super.key, required this.restaurant});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  void initState() {
    super.initState();
    final bookmarkIconProvider = context.read<BookmarkIconProvider>();
    final localDatabaseProvider = context.read<LocalDatabaseProvider>();

    Future.microtask(() async {
      await localDatabaseProvider.getFavoriteRestaurantById(
        widget.restaurant.id,
      );
      bookmarkIconProvider.isBookmarked =
          localDatabaseProvider.favoriteRestaurantList
              ?.where((restaurant) => restaurant.id == widget.restaurant.id)
              .isNotEmpty ??
          false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: () async {
        final listProvider = context.read<LocalDatabaseProvider>();
        final iconProvider = context.read<BookmarkIconProvider>();
        final bookmarked = iconProvider.isBookmarked;

        if (bookmarked) {
          await listProvider.removeFavoriteRestaurantById(widget.restaurant.id);
        } else {
          await listProvider.addFavoriteRestaurant(widget.restaurant);
        }
        await listProvider.getAllFavoriteRestaurant();
        iconProvider.isBookmarked = !bookmarked;
      },
      icon: Icon(
        context.watch<BookmarkIconProvider>().isBookmarked
            ? Icons.favorite
            : Icons.favorite_outline,
        color: Colors.white,
      ),
    );
  }
}
