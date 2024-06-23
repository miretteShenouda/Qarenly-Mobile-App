import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qarenly/controller/filter_controller.dart';

import '../model/laptop_model.dart';
import '../model/product_model.dart';

class HomePageController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxList<Product> products = <Product>[].obs;
  final RxList<Product> savedItems = <Product>[].obs;
  int limit = 5;

  final FilterController filterController = Get.put(FilterController());
  final categories = ["Laptops", "CPUs", "GPUs", "TVs"];

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    filterController.categoryFilter.listen((_) => fetchFilteredProducts());
    fetchHomepageItems();
  }

  Future<void> fetchFilteredProducts() async {
    isLoading.value = true;
    products.clear();
    try {
      String selectedCategory = filterController.categoryFilter.value;
      // RangeValues priceRange = filterController.priceFilter.value;

      if (selectedCategory == 'All') {
        await fetchHomepageItems();
      } else {
        await _fetchCategoryProducts(selectedCategory);
      }
    } catch (e) {
      print("error fetching products: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchCategoryProducts(String category) async {
    try {
      isLoading.value = true;
      products.clear(); // Clear products list before fetching items

      final querySnapshot =
          await _firestore.collection(category).limit(limit).get();
      for (var doc in querySnapshot.docs) {
        final product = Product.fromFirestore(doc.data());
        product.type = category;
        products.add(product);
      }

      isLoading.value = false;
    } catch (error) {
      print("Error retrieving products for category $category: $error");
      isLoading.value = false;
    }
  }

  Future<void> fetchHomepageItems() async {
    try {
      isLoading.value = true;
      products.clear();
      print("heloo");
      for (var category in categories) {
        final querySnapshot =
            await _firestore.collection(category).limit(limit).get();
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
