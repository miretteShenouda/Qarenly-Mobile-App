import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  static FilterController get instance => Get.find();

  RxBool filter = false.obs;
  RxString categoryFilter = "All".obs;
  Rx<RangeValues> priceFilter = RangeValues(0, 100).obs;

  void setCategoryFilter(String category) {
    categoryFilter.value = category;
    filter.value = true;
  }

  void setPriceFilter(RangeValues values) {
    priceFilter.value = values;
    filter.value = true;
  }
}
// import 'package:get/get.dart';

// class FilterController extends GetxController {
//   RxString categoryFilter = 'All'.obs;
//   Rx<RangeValues> priceFilter = RangeValues(0, 1000).obs;

//   void setCategoryFilter(String category) {
//     categoryFilter.value = category;
//   }

//   void setPriceFilter(RangeValues values) {
//     priceFilter.value = values;
//   }
// }