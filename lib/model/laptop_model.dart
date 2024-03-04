// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:qarenly/model/product_model.dart';

class Laptop extends Product {
  String cpu;
  String gpu;
  String storage;
  String model;
  Laptop(
      {required String brand,
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
      required avg_prices,
      required this.cpu,
      required this.gpu,
      required this.storage,
      required this.model})
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
