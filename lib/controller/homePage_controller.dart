import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/laptop_model.dart';
import '../model/product_model.dart';

class HomePageController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxList<Product> products = <Product>[].obs;
  final RxList<Product> savedItems = <Product>[].obs;
  int limit = 5;

  final categories = ["Laptops" , "CPUs" , "GPUs" , "TVs"];

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHomepageItems();
  }

  Future<void> fetchHomepageItems() async {
    try {
      isLoading.value = true;

      for (var category in categories) {
        final querySnapshot = await _firestore
            .collection(category)
            .limit(limit)
            .get();
        for (var doc in querySnapshot.docs) {
          final product = Product.fromFirestore(doc.data());
          product.type = category;
          print("Product ID: ${product.id}"); // Print the product.id;
          products.add(product);
        }
      }

      isLoading.value = false;
    } catch (error) {
      print("Error retrieving saved items: $error");
      isLoading.value = false;
    }
  }
}
