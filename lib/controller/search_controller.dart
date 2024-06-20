import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qarenly/controller/filter_controller.dart';
import '../model/product_model.dart';
import 'package:get/get.dart';

class SearchResultController {
  FilterController filterController = Get.put(FilterController());

  Future<RxList> searchProducts(String query) async {
    String collection = filterController.categoryFilter.value;

    if (collection == "All") return searchAllProducts(query);

    RxList<Product> searchReturn = <Product>[].obs;

    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(collection).get();

    snapshot.docs.forEach((doc) {
      final Product product =
          Product.fromFirestore(doc.data() as Map<String, dynamic>);
      product.type = collection;
      if (product.name.toLowerCase().contains(query.toLowerCase())) {
        searchReturn.add(product);
      }
    });

    return searchReturn;
  }

  Future<RxList> searchAllProducts(String query) async {
    int limit = 7;
    RxList<Product> searchReturn = <Product>[].obs;

    List collections = ["TVs", "Laptops", "CPUs", "GPUs"];

    for (var collection in collections) {
      RxList<Product> searchReturnCollection = <Product>[].obs;

      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection(collection).get();

      snapshot.docs.forEach((doc) {
        final Product product =
            Product.fromFirestore(doc.data() as Map<String, dynamic>);
        product.type = collection;
        if (product.name.toLowerCase().contains(query.toLowerCase())) {
          searchReturnCollection.add(product);
        }
      });

      for (int i = 0; i < limit; i++) {
        if (i < searchReturnCollection.length) {
          searchReturn.add(searchReturnCollection[i]);
        }
      }
    }
    return searchReturn;
  }
}
