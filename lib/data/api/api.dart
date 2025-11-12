import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:new_fundamental_submission/data/request/add_review_request.dart';
import 'package:new_fundamental_submission/data/response/add_review_response.dart';
import 'package:new_fundamental_submission/data/response/detail_restaurant_response.dart';
import 'package:new_fundamental_submission/data/response/list_restaurant_response.dart';
import 'package:new_fundamental_submission/data/response/search_restaurant_response.dart';

class Api {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<ListRestaurantResponse> getListRestaurant() async {
    final response = await http.get(Uri.parse('$baseUrl/list'));

    if (response.statusCode == 200) {
      return ListRestaurantResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch restaurant list');
    }
  }

  Future<DetailRestaurantResponse> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/detail/$id'));

    if (response.statusCode == 200) {
      return DetailRestaurantResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch restaurant detail');
    }
  }

  Future<List<String>> getListRestaurantCategory() async {
    Set<String> categories = {};
    final response = await getListRestaurant();

    final futures = response.restaurants
        .map((e) => getDetailRestaurant(e.id))
        .toList();

    final details = await Future.wait(futures);

    for (final detail in details) {
      categories.addAll(
        detail.restaurant.categories.map((category) => category.name),
      );
    }

    return categories.toList()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
  }

  Future<SearchRestaurantResponse> getSearchRestaurant(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search?q=$query'));

    if (response.statusCode == 200) {
      return SearchRestaurantResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to search restaurant');
    }
  }

  Future<AddReviewResponse> postReviewRestaurant(
    String id,
    String name,
    String review,
  ) async {
    final body = AddReviewRequest(id: id, name: name, review: review);

    final response = await http.post(
      Uri.parse('$baseUrl/review'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body.toJson()),
    );

    if (response.statusCode == 201) {
      return AddReviewResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add review');
    }
  }

  Future<Uint8List> getByteArrayFromUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }

  Future<String> downloadAndSaveFile(String url, String fileName) async {
    final bytes = await getByteArrayFromUrl(url);

    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final File file = File(filePath);
    await file.writeAsBytes(bytes);
    return filePath;
  }
}
