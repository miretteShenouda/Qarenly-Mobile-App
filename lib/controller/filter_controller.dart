import 'package:get/get.dart';

class FilterController extends GetxController {
  static FilterController get instance => Get.find();

  RxBool filter = false.obs;
  RxString categoryFilter = "All".obs;

  void setCategoryFilter(String category) {
    categoryFilter.value = category;
    filter.value = true;
  }
}
