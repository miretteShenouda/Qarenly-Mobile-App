import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qarenly/model/product_model.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';

class ViewProductController extends GetxController {
  static ViewProductController get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late TextEditingController searchController;
  late Future<DocumentSnapshot<Map<String, dynamic>>?> documentFuture;
  Rxn<Map<String, dynamic>> documentData = Rxn<Map<String, dynamic>>();
  RxBool isLoading = RxBool(true); // Initial value is true
  late List<Product> similarItems = [];
  bool isNotified = false;
  bool isSaved = false;

  String? _productId;
  String? _productType;

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
  }

  void initSavedState(){
    if (AuthenticationRepo.instance.userData!.savedItems!.any((element) {
      return element.id == _productId;
    })) {
      isSaved = true;
      print("isSaved: $isSaved");
    } else {
      isSaved = false;
      print("isSaved: $isSaved");
    };
  }

  Future<bool> toggleSavedItem() async {
    print(AuthenticationRepo.instance.userData!.savedItems);
    if (isSaved) {
      AuthenticationRepo.instance.userData!.savedItems!.removeWhere((element) {
        return element.id == _productId;
      });
    } else {
      DocumentReference productRef =
          _db.collection(_productType!).doc(_productId!);
      AuthenticationRepo.instance.userData!.savedItems!.add(productRef);
    }

    AuthenticationRepo.instance
        .UpdateUser(AuthenticationRepo.instance.userData!);

    return isSaved;
  }

  void initDependencies(BuildContext context) {
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      _productId = args['productId'] as String?;
      _productType = args['productType'] as String?;
    }
    documentFuture = _initializeDocumentFuture();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?>
      _initializeDocumentFuture() async {
    if (_productId != null && _productType != null) {
      try {
        isLoading.value =
            true; // Set isLoading to true when starting to fetch data
        final result = await getProductDetails(_productId!, _productType!);

        if (result != null) {
          documentData.value = result.data();
          return result;
        } else {
          return null;
        }
      } finally {
        isLoading.value =
            false; // Set isLoading to false after data fetching is completed (whether success or error)
      }
    } else {
      return null;
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> getProductDetails(
    String productId,
    String productType,
  ) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _db.collection(productType).doc(productId).get();

      if (snapshot.exists) {
        return snapshot;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching product details: $e');
      return null;
    }
  }

  void getSimilarProducts() async {
    RxList<Product> searchReturn = <Product>[].obs;

    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Laptops').get();

    snapshot.docs.forEach((doc) {
      final Product product =
          Product.fromFirestore(doc.data() as Map<String, dynamic>);
      print("blaaaaa");
      print(product.benchmark_ratio);
      product.type = 'Laptops';
      print("kkk");
      print(documentData.value!['benchmark_ratio']);
      if (product.benchmark_ratio >=
              documentData.value!['benchmark_ratio'] - 5 &&
          product.benchmark_ratio <=
              documentData.value!['benchmark_ratio'] + 5) {
        searchReturn.add(product);
        similarItems.add(product);
      }
    });

    // return searchReturn;
  }
}





// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ViewProductController<T> extends GetxController {
//   static ViewProductController get instance => Get.find();

//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   late TextEditingController searchController;
//   late ViewProductController _controller;
//   // late Future<DocumentSnapshot?> documentFuture;
//   late Future<DocumentSnapshot<Map<String, dynamic>>?> documentFuture;

//   // Map<String, dynamic>? documentData;
//     Rxn<Map<String, dynamic>> documentData = Rxn<Map<String, dynamic>>();

//   String? _productId;
//   String? _productType;

//   @override
//   void onInit() {
//     super.onInit();
//     _controller = ViewProductController();
//     searchController = TextEditingController();
//   }

//   void initDependencies(BuildContext context) {
//     Map<String, dynamic>? args =
//         ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

//     if (args != null) {
//       _productId = args['productId'] as String?;
//       _productType = args['productType'] as String?;
//     }
//     documentFuture = _initializeDocumentFuture();
//   }

//   Future<DocumentSnapshot<Map<String, dynamic>>?>
//       _initializeDocumentFuture() async {
//     print('productID: ${_productId} product Type: ${_productType} blaaaaabb');

//     if (_productId != null && _productType != null) {
//       print('productID: ${_productId} product Type: ${_productType} blaaaaa');
//       final result =
//           await _controller.getProductDetails(_productId!, _productType!);

//       if (result != null) {
//         // final Map<String, dynamic>? documentData = result.data();
//         // getProductData(_productId, _productType);
//         documentData = result.data();

//         return result;
//       } else {
//         return null;
//       }
//     } else {
//       return null;
//     }
//   }

//   // Future<void> getProductData(String? _productId, String? _productType) async {
//   //   final result = await getProductDetails(_productId!, _productType!);
//   //   documentData = result?.data();
//   //   print(documentData?['name']);
//   // }

//   Future<DocumentSnapshot<Map<String, dynamic>>?> getProductDetails(
//     String productId,
//     String productType,
//   ) async {
//     try {
//       print('hel');
//       final DocumentSnapshot<Map<String, dynamic>> snapshot =
//           await _db.collection(productType).doc(productId).get();

//       if (snapshot.exists) {
//         // documentData = snapshot.data();
//         return snapshot;
//       } else {
//         return null;
//       }
//     } catch (e) {
//       print('Error fetching product details: $e');
//       return null;
//     }
//   }
// }