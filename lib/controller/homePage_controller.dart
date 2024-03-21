import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../model/laptop_model.dart';
import '../model/product_model.dart';

class HomePageController extends GetxController {
  static HomePageController get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  final RxList<Product> savedItems = <Product>[].obs;
  RxBool isLoading = true.obs; // Define isLoading as a RxBool

  @override
  void onInit() {
    super.onInit();
    fetchSavedItems();
  }

  Future<List<Product>> fetchSavedItems() async {
    try {
      if (kDebugMode) {
        print("hello");
      }
      isLoading.value = true; // Set isLoading to true before fetching
      const userId = 'kqX7HeWwwOZGKhvqdQCf'; // Replace with the actual user ID
      final userDocSnapshot = await _db.collection("Users").doc(userId).get();
      if (kDebugMode) {
        print("hello2");
      }

      if (userDocSnapshot.exists && userDocSnapshot.data() != null) {
        if (kDebugMode) {
          print("hello3");
        }

        final userData = userDocSnapshot.data() as Map<String, dynamic>;
        //print(userData.length);
        List savedItemsData = userData['SavedItems'];

        if (kDebugMode) {
          print("hello4");
        }

        List<DocumentReference> savedItemsReferences =
            List<DocumentReference>.from(savedItemsData);

        if (kDebugMode) {
          print("hello5");
        }
        // for (dynamic savedItemData in savedItemsData) {
        for (DocumentReference ref in savedItemsReferences) {
          DocumentSnapshot productDocSnapshot = await ref.get();
          if (kDebugMode) {
            print("Product Document Snapshot: ${productDocSnapshot.data()}");
          }

          if (productDocSnapshot.exists) {
            // Extract data from the referenced document
            if (kDebugMode) {
              print("hello6");
            }

            Laptop laptop = Laptop.fromFirestore(
                productDocSnapshot.data() as Map<String, dynamic>);

            if (kDebugMode) {
              print("Parsed laptop data:${laptop.cpu} ${laptop.aboutItem}");
            }

            savedItems.add(laptop as Product);
            if (kDebugMode) {
              print("Added laptop to savedItems");
            }
          }
          if (kDebugMode) {
            print(savedItems.length);
          }
          // print(productDocSnapshot.data());

          if (kDebugMode) {
            print("hello7");
          }
        } // Handle the case where SavedItems is not a list (maybe log an error or handle it accordingly)
      }
      isLoading.value = false; // Set isLoading to false after fetching
    } catch (error) {
      if (kDebugMode) {
        print("Error retrieving saved items: $error");
      }
      // Handle error
      isLoading.value = false; // Set isLoading to false in case of error
    }
    return savedItems;
  }

  Future<void> deleteProduct(Product product) async {
    try {
      const userId = 'kqX7HeWwwOZGKhvqdQCf'; // Replace with the actual user ID
      final userDocRef = _db.collection('Users').doc(userId);
      final savedItemsData = (await userDocRef.get()).data()?['SavedItems'];

      if (savedItemsData != null) {
        final updatedSavedItems = List<DocumentReference>.from(savedItemsData)
            .where((ref) => ref.id != product.id)
            .toList();

        await userDocRef.update({'SavedItems': updatedSavedItems});
        savedItems.remove(product);
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error deleting product: $error");
      }
    }
  }
}
