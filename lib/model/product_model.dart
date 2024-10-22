// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class Product {
  String brand;
  String id;
  String name;
  String description;
  String techDescription;
  String aboutTable;
  String aboutItem;
  String imageUrl;
  String? type;
  double benchmark;
  double benchmark_ratio;
  List<Map> sources;
  List<double> lowestPrices;
  List<String> dates;
  String? comparison;
  IconData? arrow;
  Product({
    required this.brand,
    required this.id,
    required this.name,
    required this.description,
    required this.techDescription,
    required this.aboutTable,
    required this.aboutItem,
    required this.imageUrl,
    required this.benchmark,
    required this.benchmark_ratio,
    required this.sources,
    required this.lowestPrices,
    required this.dates,
    this.comparison,
    this.arrow,

    // required avg_prices,
  });

  static Product fromFirestore(Map<String, dynamic> data) {
    return Product(
      brand: data['brand'] ?? '',
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      description: data['desc'] ?? '',
      techDescription: data['tech_desc'] ?? '',
      aboutTable: data['about_table'] ?? '',
      aboutItem: data['about_item'] ?? '',
      imageUrl: data['image_URL'] ?? '',
      benchmark: (data['benchmark'] ?? 0.0).toDouble(),
      benchmark_ratio: (data['benchmark_ratio'] ?? 0.0).toDouble(),
      sources: (data['sources'] ?? []).cast<Map>(),
      lowestPrices: List<double>.from((data['lowest_prices'] as List<dynamic>?)
              ?.map((price) => (price as num).toDouble()) ??
          []),
      dates: (data['dates'] ?? [])
          .map<String>((timestamp) => timestamp.toString())
          .toList(),
    );
  }
}
