import 'dart:ffi';
import 'dart:core';
import 'package:qarenly/model/product_model.dart';

class Storage extends Product {
  String architecture;
  String size;
  String speed;

  Storage(
      {required this.architecture,
      required this.size,
      required this.speed,
      required String brand,
      required String id,
      required String name,
      required String description,
      required String techDescription,
      required String aboutTable,
      required String aboutItem,
      required String imageUrl,
      required Float benchmark,
      required List<String> sources,
      required List<Float> lowest_prices,
      required List<DateTime> dates,
      required avg_prices})
      : super(
            brand: brand,
            id: id,
            name: name,
            description: description,
            techDescription: techDescription,
            aboutTable: aboutTable,
            aboutItem: aboutItem,
            imageUrl: imageUrl,
            benchmark: benchmark,
            sources: sources,
            lowest_prices: lowest_prices,
            dates: dates,
            avg_prices: avg_prices);
}
