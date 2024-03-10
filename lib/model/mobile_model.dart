import 'dart:ffi';
import 'dart:core';
import 'package:qarenly/model/product_model.dart';

class Mobile extends Product {
  String cpu;
  String ram;
  String storage;
  String systemType;

  Mobile(
      {required this.cpu,
      required this.ram,
      required this.storage,
      required this.systemType,
      required String brand,
      required String id,
      required String name,
      required String description,
      required String techDescription,
      required String aboutTable,
      required String aboutItem,
      required String imageUrl,
      required double benchmark,
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
          //  lowest_prices: lowest_prices,
          dates: dates,
          //  avg_prices: avg_prices
        );
}
