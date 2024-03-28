import 'dart:core';
import 'package:qarenly/model/product_model.dart';

class Monitors extends Product {
  String screenSize;
  String refreshRate;
  String displayResolution;
  String displayType;
  String dimensions;

  Monitors({
    required this.screenSize,
    required this.refreshRate,
    required this.displayResolution,
    required this.displayType,
    required this.dimensions,
    required String brand,
    required String id,
    required String name,
    required String description,
    required String techDescription,
    required String aboutTable,
    required String aboutItem,
    required String imageUrl,
    required double benchmark,
    required List<Map> sources,
    required List<double> lowestPrices,
    required List<DateTime> dates,
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
          sources: sources,
          lowestPrices: lowestPrices,
          dates: dates,
        );
}
