import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qarenly/model/product_model.dart';

class FilterController extends GetxController {
  static FilterController get instance => Get.find();

  RxBool filter = false.obs;
  RxString categoryFilter = "All".obs;

  RxDouble priceFilterLowerBound = 0.0.obs;
  RxDouble priceFilterUpperBound = 9999999999999.0.obs;

  RxList<String> Sources = <String>[].obs;

  void setCategoryFilter(String category) {
    categoryFilter.value = category;
    filter.value = true;
  }

  List viewSourceProducts(String source, RxList<Product> searchReturn) {
    List<Product> filterdProducts = [];
    for (var product in searchReturn.value) {
      if (product.sources.any((element) => element['website'] == source)) {
        filterdProducts.add(product);
      }
    }
    return filterdProducts;
  }
}
