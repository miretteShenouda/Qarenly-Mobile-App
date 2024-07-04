import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qarenly/controller/savedItems_controller.dart';
import 'package:qarenly/model/product_model.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';

class ViewProductController extends GetxController {
  static ViewProductController get instance => Get.find();

  SavedItemsController savedItemsController = Get.put(SavedItemsController());
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

  String? get productType => _productType;

  String? get productId => _productId;

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
    } else {
      isSaved.value = false;
    }
    ;
  }

  List<dynamic> sortProductSources(List<dynamic> sources) {
    List<dynamic> inStock = [];
    List<dynamic> outStock = [];
    for (var source in sources) {
      if (source['stock_status']) {
        inStock.add(source);
      } else {
        outStock.add(source);
      }
    }

    return [...inStock, ...outStock];
  }

  Future<bool> toggleSavedItem() async {
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

    savedItemsController.fetchSavedItems();

    isSaved.value = !isSaved.value;

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
      if (product.benchmark_ratio > benchmarkRatio) {
        product.comparison =
            "${(product.benchmark_ratio - benchmarkRatio).toStringAsPrecision(2)}%";
        product.arrow = Icons.arrow_circle_up_outlined;
      } else if (product.benchmark_ratio < benchmarkRatio) {
        product.comparison =
            "${(benchmarkRatio - product.benchmark_ratio).toStringAsPrecision(2)}%";
        product.arrow = Icons.arrow_circle_down_outlined;
      } else {
        product.comparison = "equal";
      }
    }
    similarItems = searchReturn;

    isLoading.value =
        false; // Set isLoading to false after data fetching is completed (whether success or error)
  }
}
