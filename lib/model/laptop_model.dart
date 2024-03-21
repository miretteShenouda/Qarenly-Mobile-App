// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
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
      required List<Map> sources,
      required List<double> lowestPrices,
      required List<DateTime> dates,
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
      lowestPrices: List<double>.from(
          data['lowestPrices'].map((price) => price.toDouble())),
      dates: (data['dates'] as List<dynamic>?)
              ?.map((timestamp) => (timestamp as Timestamp).toDate())
              .toList() ??
          [],
      cpu: data['CPU'] ?? '',
      gpu: data['GPU'] ?? '',
      storage: data['storage'] ?? '',
      model: data['model'] ?? '',
    );
  }
}
