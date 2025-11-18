import 'package:flutter/material.dart';
import 'package:new_fundamental_submission/data/api/utils.dart';
import 'package:new_fundamental_submission/provider/search/search_restaurant_list_provider.dart';
import 'package:new_fundamental_submission/static/navigation/navigation_route.dart';
import 'package:new_fundamental_submission/static/state/restaurant_list_result_state.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  final String? query;
  const SearchScreen({super.key, this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;
      if (widget.query != null) {
        if (widget.query!.isNotEmpty) {
          _textEditingController.text = widget.query!;
          context
              .read<SearchRestaurantListProvider>()
              .fetchSearchRestaurantList(widget.query!);
        }
      }
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                spacing: 4,
                children: [
                  IconButton(
                    onPressed: () {
                      context
                          .read<SearchRestaurantListProvider>()
                          .resetSearchRestaurantList();
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hint: Text('Start your search here'),
                      ),
                      maxLines: 1,
                    ),
                  ),
                  IconButton.filled(
                    onPressed: () {
                      final query = _textEditingController.text.trim();
                      if (query.isNotEmpty) {
                        context
                            .read<SearchRestaurantListProvider>()
                            .fetchSearchRestaurantList(query);
                      }
                    },
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Consumer<SearchRestaurantListProvider>(
                  builder: (context, value, child) {
                    return switch (value.resultState) {
                      RestaurantListSuccessState(:final data) =>
                        data.isEmpty
                            ? const Center(child: Text('Not Found'))
                            : ListView.separated(
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
                                          Utils.smallImageUrl(
                                            restaurant.pictureId,
                                          ),
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
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge,
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
            ],
          ),
        ),
      ),
    );
  }
}
