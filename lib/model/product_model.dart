// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

class Product {
  String brand;
  String id;
  String name;
  String description;
  String techDescription;
  String aboutTable;
  String aboutItem;
  String imageUrl;
  double benchmark;
  List<String> sources;
  //List<double> lowest_prices;
  late List<DateTime> dates;
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
    required this.sources,
    // required this.lowest_prices,
    required this.dates,
    // required avg_prices,
  });
}
