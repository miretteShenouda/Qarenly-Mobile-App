//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/laptop_model.dart';
import '../model/product_model.dart';

// class ViewProductController extends GetxController {
//   static ViewProductController get instance => Get.find();

//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   @override
//   void onInit() {
//     super.onInit();
//     //getProductDetails(productId);
//   }

//   Future<void> getProductDetails(String productId) async {
//     DocumentSnapshot<Map<String, dynamic>> snapshot =
//         await _db.collection('Laptops').doc(productId).get();
//         final Map<String, dynamic>? productData =
//                     snapshot.data();
//                      if (productData != null) {
//                   final Laptop laptop = Laptop.fromFirestore(productData);
//                 } }
// }

class ViewProductController<T> extends GetxController {
  static ViewProductController get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    // Initialization code if needed
  }

  Future<T?> getProductDetails(
      String productId, T Function(Map<String, dynamic>) fromFirestore) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _db.collection('products').doc(productId).get();

      if (snapshot.exists) {
        final Map<String, dynamic> productData = snapshot.data()!;
        return fromFirestore(productData);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching product details: $e');
      return null;
    }
  }
}
