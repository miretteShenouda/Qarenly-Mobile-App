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
  RxBool isSaved = false.obs;

  String? _productId;
  String? _productType;

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
  }

  void initSavedState() {
    if (AuthenticationRepo.instance.userData == null ||
        AuthenticationRepo.instance.userData!.savedItems == null) {
      isSaved.value = false;
      return;
    }

    if (AuthenticationRepo.instance.userData!.savedItems!.any((element) {
      return element.id == _productId;
    })) {
      isSaved.value = true;
      print("isSaved: $isSaved");
    } else {
      isSaved.value = false;
      print("isSaved: $isSaved");
    }
    ;
  }

  Future<bool> toggleSavedItem() async {
    print(AuthenticationRepo.instance.userData!.savedItems);
    if (isSaved.value) {
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
    isSaved.value= !isSaved.value;

    return isSaved.value;
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
        // isLoading.value = false;
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
    /// CHANGED THE IMPLEMENTATION FROM FOR LOOP TO WHERE CALUSE FOR FASTER RETRIEVAL AND LIMIT CAPAPILITES.

    similarItems.clear(); // clearing the similarItems list
    RxList<Product> searchReturn = <Product>[].obs;

    final result = await getProductDetails(_productId!,
        _productType!); // Making sure that the document is not null before accessing it

    if (result != null) {
      documentData.value = result.data();
    } else {
      return;
    }
    double benchmarkRatio = documentData.value!['benchmark_ratio'];

    print("Product Type in Controller: $_productType");
    print("Document benchmark: ${documentData.value!['benchmark_ratio']}");
    QuerySnapshot snapshot1 = await FirebaseFirestore.instance
        .collection(_productType!)
        .where("benchmark_ratio",
            isGreaterThanOrEqualTo: documentData.value!['benchmark_ratio'] -
                5) // more or equal to -5
        .where("benchmark_ratio",
            isLessThanOrEqualTo: documentData
                .value!['benchmark_ratio']) // less or equal to his value
        .where("name", isNotEqualTo: documentData.value!['name'])
        .limit(5)
        .get(); // Query for Products less than him

    QuerySnapshot snapshot2 = await FirebaseFirestore.instance
        .collection(_productType!)
        .where("benchmark_ratio",
            isLessThanOrEqualTo: documentData.value!['benchmark_ratio'] +
                5) // less or equal to +5
        .where("benchmark_ratio",
            isGreaterThanOrEqualTo: documentData
                .value!['benchmark_ratio']) // more or equal to his value
        .where("name", isNotEqualTo: documentData.value!['name'])
        .limit(5)
        .get(); // Query for Products more than him

    searchReturn.addAll(snapshot1.docs.map(
        (doc) => Product.fromFirestore(doc.data() as Map<String, dynamic>)));
    searchReturn.addAll(snapshot2.docs.map(
        (doc) => Product.fromFirestore(doc.data() as Map<String, dynamic>)));
    for (var product in searchReturn) {
      product.type = _productType;
      // product.comparison = product.benchmark_ratio > benchmarkRatio
      //     ? " higher"
      //     : product.benchmark_ratio < benchmarkRatio
      //         ? "lower"
      //         : "equal";
      if (product.benchmark_ratio > benchmarkRatio) {
        product.comparison =
            "${(product.benchmark_ratio - benchmarkRatio).toStringAsPrecision(3)}%";
        product.arrow = Icons.arrow_circle_up_outlined;
      } else if (product.benchmark_ratio < benchmarkRatio) {
        product.comparison =
            "${(benchmarkRatio - product.benchmark_ratio).toStringAsPrecision(3)}%";
        product.arrow = Icons.arrow_circle_down_outlined;
      } else {
        product.comparison = "equal";
      }
    }
    similarItems = searchReturn;

    print(similarItems);

    for (var item in similarItems) {
      print(item.name);
    }

    isLoading.value =
        false; // Set isLoading to false after data fetching is completed (whether success or error)

    // QuerySnapshot snapshot =
    //     await FirebaseFirestore.instance.collection(_productType!).get();

    // snapshot.docs.forEach((doc) {
    //   final Product product =
    //       Product.fromFirestore(doc.data() as Map<String, dynamic>);
    //   print("blaaaaa");
    //   print(product.benchmark_ratio);
    //   product.type = _productType;
    //   print("kkk");
    //   print(documentData.value!['benchmark_ratio']);
    //   if (product.benchmark_ratio >=
    //           documentData.value!['benchmark_ratio'] - 5 &&
    //       product.benchmark_ratio <=
    //           documentData.value!['benchmark_ratio'] + 5) {
    //     searchReturn.add(product);
    //     similarItems.add(product);
    //   }
    // });

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