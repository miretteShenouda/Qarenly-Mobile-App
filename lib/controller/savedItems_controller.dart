import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qarenly/model/user_model.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';
import '../model/product_model.dart';

class SavedItemsController extends GetxController {
  RxList<Product> savedItemsProducts = <Product>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<Product>> fetchSavedItems() async {
    final List<Product> savedItems = [];
    try {
      final userId = AuthenticationRepo.instance.currentUser!.uid;
      UserModel userData = AuthenticationRepo.instance.userData!;

      if (userData.savedItems!.isNotEmpty) {
        for (DocumentReference map in userData.savedItems!) {
          String path = map.path;
          String collection = path.split('/')[0];
          DocumentSnapshot productDocSnapshot = await map.get();
          Map<String, dynamic>? data =
              productDocSnapshot.data() as Map<String, dynamic>?;

          if (data != null) {
            Product product = Product.fromFirestore(data);
            product.type = collection;
            savedItems.add(product);
          }
        }
      }
      savedItemsProducts.value = savedItems;
      isLoading.value = false;
      return savedItems;
    } catch (error) {}
    isLoading.value = false;
    return [];
  }

  Future<void> deleteProduct(Product product) async {
    try {
      final savedItemsData = AuthenticationRepo.instance.userData!.savedItems;

      if (savedItemsData != null) {
        savedItemsData.removeWhere((ref) => ref.id == product.id);
        savedItemsProducts.removeWhere((element) => element.id == product.id);

        AuthenticationRepo.instance.userData!.savedItems = savedItemsData;
        AuthenticationRepo.instance
            .UpdateUser(AuthenticationRepo.instance.userData!);
      }
    } catch (error) {
      print("Error deleting product: $error");
    }
  }
}
