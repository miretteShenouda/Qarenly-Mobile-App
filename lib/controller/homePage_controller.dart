import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/laptop_model.dart';
import '../model/product_model.dart';

class HomePageController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxList<Product> laptops = <Product>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLaptops();
  }

  Future<void> fetchLaptops() async {
    try {
      if (kDebugMode) {
        print("Fetching laptops...");
      }
      isLoading.value = true;

      final laptopsSnapshot = await _firestore.collection("Laptops").get();

      if (laptopsSnapshot.docs.isNotEmpty) {
        laptops.clear();
        laptops.addAll(
          laptopsSnapshot.docs.map(
            (doc) {
              Laptop laptop =
                  Laptop.fromFirestore(doc.data() as Map<String, dynamic>);
              return laptop as Product;
            },
          ),
        );
      }

      isLoading.value = false;
    } catch (error) {
      if (kDebugMode) {
        print("Error retrieving laptops: $error");
      }
      isLoading.value = false;
      // Handle error gracefully, show feedback to user
      Get.snackbar(
        'Error',
        'Failed to retrieve laptops. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
