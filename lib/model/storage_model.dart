import 'dart:core';

import 'package:qarenly/model/product_model.dart';

class Storage extends Product {
  String architecture;
  String size;
  String speed;

  Storage({
    required this.architecture,
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
    required double benchmark,
    required double benchmark_ratio,
    required List<Map> sources,
    required List<double> lowestPrices,
    required List<String> dates,
  }) : super(
          brand: brand,
          id: id,
          name: name,
          description: description,
          techDescription: techDescription,
          aboutTable: aboutTable,
          aboutItem: aboutItem,
          imageUrl: imageUrl,
          benchmark: benchmark,
          benchmark_ratio: benchmark_ratio,
          sources: sources,
          lowestPrices: lowestPrices,
          dates: dates,
        );
}
