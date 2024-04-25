import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/laptop_model.dart';
import '../model/product_model.dart';

class HomePageController extends GetxController {
  static HomePageController get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final RxList<Product> savedItems = <Product>[].obs;
  RxBool isLoading = true.obs; // Define isLoading as a RxBool

  @override
  void onInit() {
    super.onInit();
    fetchSavedItems();
  }

  Future<void> fetchSavedItems() async {
    try {
      isLoading.value = true;
      final userId = 'kqX7HeWwwOZGKhvqdQCf'; // Replace with the actual user ID
      final userDocSnapshot = await _db.collection("Users").doc(userId).get();

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
                await _db.collection(productType).doc(documentId).get();

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

  Future<void> deleteProduct(Product product) async {
    try {
      final userId = 'kqX7HeWwwOZGKhvqdQCf'; // Replace with the actual user ID
      final userDocRef = _db.collection('Users').doc(userId);
      final savedItemsData = (await userDocRef.get()).data()?['SavedItems'];

      if (savedItemsData != null) {
        final updatedSavedItems =
            savedItemsData.where((ref) => ref.id != product.id).toList();

        await userDocRef.update({'SavedItems': updatedSavedItems});
        savedItems.remove(product);
      }
    } catch (error) {
      print("Error deleting product: $error");
    }
  }
}

class ProductWithType {
  final String type;
  final Product product;

  ProductWithType({required this.type, required this.product});
}
