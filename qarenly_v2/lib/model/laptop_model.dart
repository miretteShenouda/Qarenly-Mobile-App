// ignore_for_file: public_member_api_docs, sort_constructors_first

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
      required double benchmark_ratio,
      required List<Map> sources,
      required List<double> lowestPrices,
      required List<String> dates,
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
          benchmark_ratio: benchmark_ratio,
          sources: sources,
          lowestPrices: lowestPrices,
          dates: dates,
        );
  factory Laptop.fromFirestore(Map<String, dynamic>? data) {
    if (data == null) {
      throw ArgumentError('Data is null');
    }

    return Laptop(
      sources: List<Map>.from(data['sources'] ?? []),
      aboutItem: data['about_item'] ?? '',
      aboutTable: data['about_table'] ?? '',
      brand: data['brand'] ?? '',
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      description: data['desc'] ?? '',
      techDescription: data['tech_desc'] ?? '',
      imageUrl: data['image_URL'] ?? '',
      benchmark: (data['benchmark'] as num?)?.toDouble() ?? 0.0,
      benchmark_ratio: (data['benchmark_ratio'] as num?)?.toDouble() ?? 0.0,
      lowestPrices: List<double>.from((data['lowest_prices'] as List<dynamic>?)
              ?.map((price) => (price as num).toDouble()) ??
          []),
      dates: (data['dates'] ?? [])
          .map<String>((timestamp) => timestamp.toString())
          .toList(),
      cpu: data['CPU'] ?? '',
      gpu: data['GPU'] ?? '',
      storage: data['storage'] ?? '',
      model: data['model'] ?? '',
    );
  }
}
