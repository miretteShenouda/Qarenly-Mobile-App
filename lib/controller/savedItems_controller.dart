import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/laptop_model.dart';
import '../model/product_model.dart';

// class SavedItemsController extends GetxController {
//   static SavedItemsController get instance => Get.find();
//   final _db = FirebaseFirestore.instance;

//   final RxList<Product> savedItems = <Product>[].obs;
//   RxBool isLoading = true.obs; // Define isLoading as a RxBool

//   @override
//   void onInit() {
//     super.onInit();
//     fetchSavedItems();
//   }

//   Future<List<Product>> fetchSavedItems() async {
//     try {
//       isLoading.value = true; // Set isLoading to true before fetching
//       final userId = 'kqX7HeWwwOZGKhvqdQCf'; // Replace with the actual user ID
//       final userDocSnapshot = await _db.collection("Users").doc(userId).get();
//       if (userDocSnapshot.exists && userDocSnapshot.data() != null) {
//         final userData = userDocSnapshot.data() as Map<String, dynamic>;
//         List savedItemsData = userData['SavedItems'];
//         List<DocumentReference> savedItemsReferences =
//             List<DocumentReference>.from(savedItemsData);
//         for (DocumentReference ref in savedItemsReferences) {
//           DocumentSnapshot productDocSnapshot = await ref.get();
//           // print(
//           //     "Product Document Snapshot: ${productDocSnapshot.reference.path}");
//           String referencePath = productDocSnapshot.reference.path;
//           List<String> parts = referencePath.split('/');
//           String productType = parts[0];
//           String documentId = parts[1];
//           print("Product Type: $productType");

//           print("Document ID: $documentId");

//           DocumentReference docRef =
//               _db.collection(productType).doc(documentId);
//           DocumentSnapshot productDocSnapshot1 = await docRef.get();
//           print("Product Document Snapshot: ${productDocSnapshot1.data()}");
//           print("this is thee document....: $docRef");
//           if (productDocSnapshot1.exists) {
//             if (productType == "Laptops") {
//               Map<String, dynamic>? productData =
//                   productDocSnapshot1.data() as Map<String, dynamic>?;
//               Laptop laptop = Laptop.fromFirestore(productData!);

//               print(
//                   "Parsed laptop data:" + laptop.cpu + " " + laptop.aboutItem);
//               savedItems.add(laptop);
//             }

//             print("Added laptop to savedItems");
//           }
//         }
//       }
//       isLoading.value = false; // Set isLoading to false after fetching
//     } catch (error) {
//       print("Error retrieving saved items: $error");
//       // Handle error
//       isLoading.value = false; // Set isLoading to false in case of error
//     }
//     return savedItems;
//   }

//   Future<void> deleteProduct(Product product) async {
//     try {
//       final userId = 'kqX7HeWwwOZGKhvqdQCf'; // Replace with the actual user ID
//       final userDocRef = _db.collection('Users').doc(userId);
//       final savedItemsData = (await userDocRef.get()).data()?['SavedItems'];

//       if (savedItemsData != null) {
//         final updatedSavedItems = List<DocumentReference>.from(savedItemsData)
//             .where((ref) => ref.id != product.id)
//             .toList();

//         await userDocRef.update({'SavedItems': updatedSavedItems});
//         savedItems.remove(product);
//       }
//     } catch (error) {
//       print("Error deleting product: $error");
//     }
//   }
// }
class SavedItemsController extends GetxController {
  static SavedItemsController get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final RxList<Product> savedItems = <Product>[].obs;
  final RxBool isLoading = true.obs;

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
                  savedItems.add(laptop);
                }
              }
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
