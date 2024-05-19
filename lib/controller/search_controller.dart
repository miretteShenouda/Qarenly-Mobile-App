import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/product_model.dart';
import 'package:get/get.dart';

class SearchResultController {
  Future<RxList> searchLaptops(String query) async {
    RxList<Product> searchReturn = <Product>[].obs;

    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Laptops').get();

    snapshot.docs.forEach((doc) {
      final Product product =
          Product.fromFirestore(doc.data() as Map<String, dynamic>);
          product.type = 'Laptops';
      if (product.name.toLowerCase().contains(query.toLowerCase())) {
        searchReturn.add(product);
      }
    });

    return searchReturn;
  }
}
