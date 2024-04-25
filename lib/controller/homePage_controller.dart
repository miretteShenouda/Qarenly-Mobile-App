import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/laptop_model.dart';
import '../model/product_model.dart';

class HomePageController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxList<Product> laptops = <Product>[].obs;
  final RxList<Product> savedItems = <Product>[].obs;

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSavedItems();
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

  Future<void> fetchSavedItems() async {
    try {
      isLoading.value = true;
      final userId = 'kqX7HeWwwOZGKhvqdQCf'; // Replace with the actual user ID
      final userDocSnapshot =
          await _firestore.collection("Users").doc(userId).get();

      if (userDocSnapshot.exists) {
        final userData = userDocSnapshot.data();
        if (userData != null) {
          List<dynamic> savedItemsData = userData['SavedItems'] ?? [];
          List<DocumentReference> savedItemsReferences =
              savedItemsData.map((data) => data as DocumentReference).toList();

          for (final DocumentReference ref in savedItemsReferences) {
            final DocumentSnapshot productDocSnapshot = await ref.get();
            final String referencePath = productDocSnapshot.reference.path;
            final List<String> parts = referencePath.split('/');
            final String productType = parts[0];
            final String documentId = parts[1];
            print("Product Type: $productType");
            print("Document ID: $documentId");
            final DocumentSnapshot productDocSnapshot1 =
                await _firestore.collection(productType).doc(documentId).get();

            if (productDocSnapshot1.exists) {
              if (productType == "Laptops") {
                final Map<String, dynamic>? productData =
                    productDocSnapshot1.data() as Map<String, dynamic>?;

                if (productData != null) {
                  final Laptop laptop = Laptop.fromFirestore(productData);
                  laptop.type = productType;
                  savedItems.add(laptop);
                }
              } else {}
            }
          }
        }
      }

      isLoading.value = false;
    } catch (error) {
      print("Error retrieving saved items: $error");
      isLoading.value = false;
    }
  }
}
