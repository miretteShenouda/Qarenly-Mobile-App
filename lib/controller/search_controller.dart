import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qarenly/controller/filter_controller.dart';
import '../model/product_model.dart';
import 'package:get/get.dart';

class SearchResultController extends GetxController {
  static SearchResultController get to => Get.find();

  FilterController filterController = Get.put(FilterController());
  RxBool isLoading = false.obs;
  RxList<Product> searchReturn = <Product>[].obs;

  void searchProducts(String query) async {
    searchReturn.value = [];
    String collection = filterController.categoryFilter.value;
    double lowerBound = filterController.priceFilterLowerBound.value;
    double upperBound = filterController.priceFilterUpperBound.value;

    print(
        'collection: $collection, query: $query, lowerBound: $lowerBound, upperBound: $upperBound');

    if (collection == "All") {
      searchAllProducts(query);
      return;
    }

    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(collection).get();

    print("collection: $collection");

    snapshot.docs.forEach((doc) {
      final Product product =
          Product.fromFirestore(doc.data() as Map<String, dynamic>);
      product.type = collection;
      if (product.name.toLowerCase().contains(query.toLowerCase())) {
        for (int i = 0; i < product.sources.length; i++) {
          if (product.sources[i]["stock_status"] == false) continue;

          double price = product.sources[i]['discounted_price'] == null
              ? product.sources[i]['price']
              : product.sources[i]['discounted_price'];
          print("price: $price");
          if (price >= lowerBound && price <= upperBound) {
            searchReturn.add(product);
            break;
          }
        }
      }
    });
    print("searchReturn: $searchReturn");
  }

  void searchAllProducts(String query) async {
    int limit = 7;
    double lowerBound = filterController.priceFilterLowerBound.value;
    double upperBound = filterController.priceFilterUpperBound.value;
    // RxList<Product> searchReturn = <Product>[].obs;

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
          for (int i = 0; i < product.sources.length; i++) {
            if (product.sources[i]["stock_status"] == false) continue;

            double price = product.sources[i]['discounted_price'] == null
                ? product.sources[i]['price']
                : product.sources[i]['discounted_price'];
            if (price >= lowerBound && price <= upperBound) {
              searchReturnCollection.add(product);
              break;
            }
          }
        }
      });

      for (int i = 0; i < limit; i++) {
        if (i < searchReturnCollection.length) {
          searchReturn.add(searchReturnCollection[i]);
        }
      }
    }
  }

  void applyFilters() {
    double lowerBound = filterController.priceFilterLowerBound.value;
    double upperBound = filterController.priceFilterUpperBound.value;

    List<String> sources = filterController.Sources.value;

    if (sources.isEmpty) {
      sources = ['albadr', 'sigma', 'jumia', 'noon', 'amazon'];
    }

    print("Sources Filters $sources");

    List<Product> newSearchResult = [];
    for (var product in searchReturn.value) {
      for (var source in sources) {
        for (int i = 0; i < product.sources.length; i++) {
          if (product.sources[i]['website'] == source &&
              product.sources[i]['stock_status']) {
            double price = product.sources[i]['discounted_price'] == null
                ? product.sources[i]['price']
                : product.sources[i]['discounted_price'];
            if (price >= lowerBound && price <= upperBound) {
              if (!newSearchResult.contains(product))
                newSearchResult.add(product);
            }
          }
        }
      }
    }
    print(newSearchResult);
    searchReturn.value = newSearchResult;
    print("searchReturn: $searchReturn");
  }

  void SeacrhAndApplyFilters(String query) {
    isLoading.value = true;
    searchProducts(query);
    applyFilters();
    isLoading.value = false;
  }
}
