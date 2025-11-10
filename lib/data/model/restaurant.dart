import 'dart:convert';

import 'package:new_fundamental_submission/data/model/category.dart';
import 'package:new_fundamental_submission/data/model/customer_review.dart';
import 'package:new_fundamental_submission/data/model/menu.dart';

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<Category> categories;
  final Menus menus;
  final double rating;
  final List<CustomerReview> customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    city: json['city'],
    address: json['address'],
    pictureId: json['pictureId'],
    categories: List<Category>.from(
      json['categories'].map((x) => Category.fromJson(x)),
    ),
    menus: Menus.fromJson(json['menus']),
    rating: json['rating']?.toDouble(),
    customerReviews: List<CustomerReview>.from(
      json['customerReviews'].map((x) => CustomerReview.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'city': city,
    'address': address,
    'pictureId': pictureId,
    'categories': List<dynamic>.from(categories.map((x) => x.toJson())),
    'menus': menus.toJson(),
    'rating': rating,
    'customerReviews': List<dynamic>.from(
      customerReviews.map((x) => x.toJson()),
    ),
  };

  Map<String, dynamic> toDatabase() => {
    'id': id,
    'name': name,
    'description': description,
    'city': city,
    'address': address,
    'picture_id': pictureId,
    'categories': jsonEncode(categories.map((x) => x.toJson()).toList()),
    'menus': jsonEncode(menus.toJson()),
    'rating': rating,
    'customer_reviews': jsonEncode(
      customerReviews.map((x) => x.toJson()).toList(),
    ),
  };

  factory Restaurant.fromDatabase(Map<String, dynamic> map) => Restaurant(
    id: map['id'],
    name: map['name'],
    description: map['description'],
    city: map['city'],
    address: map['address'],
    pictureId: map['picture_id'],
    rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
    categories: (jsonDecode(map['categories']) as List)
        .map((e) => Category.fromJson(e))
        .toList(),
    menus: Menus.fromJson(jsonDecode(map['menus'])),
    customerReviews: (jsonDecode(map['customer_reviews']) as List)
        .map((e) => CustomerReview.fromJson(e))
        .toList(),
  );
}
