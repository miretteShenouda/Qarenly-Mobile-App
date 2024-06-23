import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  static FilterController get instance => Get.find();

  RxBool filter = false.obs;
  RxString categoryFilter = "All".obs;

  RxDouble priceFilterLowerBound = 0.0.obs;
  RxDouble priceFilterUpperBound = 9999999999999.0.obs;

  void setCategoryFilter(String category) {
    categoryFilter.value = category;
    filter.value = true;
  }
}
