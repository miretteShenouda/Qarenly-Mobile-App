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
      required double benchmark,
      required List<String> sources,
      //required List<Float> lowest_prices,
      required List<DateTime> dates,
      //required avg_prices,
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
          // lowest_prices: lowest_prices,
          dates: dates,
          // avg_prices: avg_prices
        );

  factory Laptop.fromFirestore(Map<String, dynamic> data) {
    return Laptop(
      sources: List<String>.from(data['sources']),
      aboutItem: data['about_item'],
      aboutTable: data['about_table'],
      brand: data['brand'],
      id: data['id'],
      name: data['name'],
      description: data['desc'],
      techDescription: data['tech_desc'],
      imageUrl: data['image_URL'],
      benchmark: (data['benchmark']).toDouble(),
      // lowest_prices: List<double>.from(data['lowest_prices'].map((price) => price.toDouble())),
      dates: List<DateTime>.from(
          data['dates'].map((timestamp) => timestamp.toDate())),
      cpu: data['CPU'],
      gpu: data['GPU'],
      storage: data['storage'],
      model: data['model'],
    );
  }
}
