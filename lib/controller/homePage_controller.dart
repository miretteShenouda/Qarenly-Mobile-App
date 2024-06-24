import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:qarenly/controller/filter_controller.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';

import '../model/product_model.dart';

class HomePageController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxList<Product> products = <Product>[].obs;
  final RxList<Product> savedItems = <Product>[].obs;
  final RxList<Product> recommendedItems = <Product>[].obs;
  final RxList<Product> recentDeals = <Product>[].obs;

  int limit = 5;

  final FilterController filterController = Get.put(FilterController());
  final categories = ["Laptops", "CPUs", "GPUs", "TVs"];

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    filterController.categoryFilter.listen((_) => fetchFilteredProducts());
    fetchHomepageItems();
    fetchRecommendedProducts();
    _fetchRecentDealsProducts();
  }

  Future<void> fetchRecommendedProducts() async {
    AuthenticationRepo.instance.userData =
        await AuthenticationRepo.instance.fetchUserData();
    try {
      isLoading.value = true;
      recommendedItems.clear();
      Map<String, List> savedItemsIds = {'ids': []};

      if (AuthenticationRepo.instance.userData!.savedItems!.isEmpty) {
        recommendedItems.value = products;
        return;
      }

      for (DocumentReference savedItem
          in AuthenticationRepo.instance.userData!.savedItems!) {
        final savedItemDoc = await savedItem.get();
        if (savedItemDoc.exists) {
          final savedItemData = savedItemDoc.data() as Map<String, dynamic>;
          savedItemsIds['ids']!.add(savedItemData['id'].toString());
        }
      } // AuthenticationRepo.instance.userData!.savedItems;

      print(savedItemsIds);

      final response = await http.post(
        Uri.parse("https://qarenlyrecommender.azurewebsites.net/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(savedItemsIds),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);

        for (var item in responseData) {
          String id = item['id'];
          String collection = item['collection'];

          DocumentSnapshot productSnapshot =
              await _firestore.collection(collection).doc(id).get();
          if (productSnapshot.exists) {
            final product = Product.fromFirestore(
                productSnapshot.data() as Map<String, dynamic>);
            product.type = collection;
            recommendedItems.add(product);
          }
        }

        print("Recommended List $responseData");
      } else {
        print(
            'Failed to fetch recommended products. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print("Error fetching recommended products: $error");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchRecentDealsProducts() async {
    try {
      isLoading.value = true;
      recentDeals.clear(); // Clear products list before fetching items

      final querySnapshot = await _firestore.collection('Recent Deals').get();
      if (querySnapshot.docs.isEmpty) {
        print("No documents found in Recent Deals collection.");
      }
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        if (data == null) {
          print("Document data is null for doc ID: ${doc.id}");
          continue;
        }

        final product = Product.fromFirestore(data);
        // print('Object ${product.id}, Name: ${product.name}');

        // // Search for product in other categories to determine its type
        // bool found = false;
        // for (var category in categories) {
        //   final categoryQuerySnapshot = await _firestore
        //       .collection(category)
        //       .where('name', isEqualTo: product.name)
        //       .get();
        //
        //   if (categoryQuerySnapshot.docs.isNotEmpty) {
        //     product.type = category;
        //     print('typeeeeeeeeee  ${product.type}');
        //     found = true;
        //     break; // Exit loop once the type is found
        //   }
        // }
        //
        // if (!found) {
        //   print("Product with ID ${product.id} not found in any category.");
        // }else{
        //   print("Product with ID ${product.id} was found in ${product.type}.");
        //
        // }

        recentDeals.add(product);
      }

      isLoading.value = false;
    } catch (error) {
      print("Error retrieving products for category Recent Deals: $error");
      isLoading.value = false;
    }
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

  List<Product> pickRandomProducts(List<Product> productList, int count) {
    if (count >= productList.length) {
      return productList; // Return all products if count is greater than or equal to list length
    }

    Random random = Random();
    List<Product> randomProducts = [];

    while (randomProducts.length < count) {
      int randomIndex = random.nextInt(productList.length);
      Product randomProduct = productList[randomIndex];
      if (!randomProducts.contains(randomProduct)) {
        randomProducts.add(randomProduct);
      }
    }

    return randomProducts;
  }

  Future<void> _fetchCategoryProducts(String category) async {
    try {
      isLoading.value = true;
      products.clear(); // Clear products list before fetching items

      final querySnapshot = await _firestore.collection(category).get();
      for (var doc in querySnapshot.docs) {
        final product = Product.fromFirestore(doc.data());
        product.type = category;
        products.add(product);
      }
      products.value = pickRandomProducts(products, 10);
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
        final querySnapshot = await _firestore.collection(category).get();
        for (var doc in querySnapshot.docs) {
          final product = Product.fromFirestore(doc.data());
          product.type = category;
          print("Product ID: ${product.id}"); // Print the product.id;
          products.add(product);
        }
      }
      products.value = pickRandomProducts(products, 10);
      isLoading.value = false;
    } catch (error) {
      print("Error retrieving saved items: $error");
      isLoading.value = false;
    }
  }
}
