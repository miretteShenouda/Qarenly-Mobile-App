import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:qarenly/model/product_model.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';

class NotificationController extends GetxController {
  static NotificationController get instance => Get.find();
  AuthenticationRepo _authenticationRepo = Get.put(AuthenticationRepo());
  RxList<Map<String, dynamic>> notifications = <Map<String, dynamic>>[].obs;
  Map<String, dynamic> notification = {};

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    validateToken();
    super.onReady();
  }

  bool existToken() {
    // if user is a guest return true ( Act as if he is a normal user with token)
    print("userData in existToken: ${_authenticationRepo.userData!}");
    if (_authenticationRepo.currentUser!.isAnonymous) {
      return true;
    }

    print(
        "notification token in existToken: ${_authenticationRepo.userData!.notificationToken}");

    if (_authenticationRepo.userData!.notificationToken != null) {
      return true;
    }

    return false;
  }

  Future<void> generateToken() async {
    _authenticationRepo.userData!.notificationToken =
        await FirebaseMessaging.instance.getToken();
    print("Token: ${_authenticationRepo.userData!.notificationToken}");
  }

  void validateToken() async {
    _authenticationRepo.userData = await _authenticationRepo.fetchUserData();
    bool bValue = !existToken();
    print("bValue: $bValue");
    if (bValue) {
      await generateToken();
      print("Update User=========");
      await _authenticationRepo.UpdateUser(_authenticationRepo.userData!);
    }
  }

  void getNotifications() {
    isLoading.value = true;
    if (_authenticationRepo.userData!.notifications != null) {
      notifications.value = _authenticationRepo.userData!.notifications!;
      isLoading.value = false;
      return;
    }
    notifications.value = [];
    isLoading.value = false;
  }

  // Future<Product?> getProduct(
  //     Map<String, dynamic> notifications, int index) async {
  //   String productName = notifications[index]["name"];

  //   //we need to fetch all products from firebase
  //   //then we need to find the product with the same name
  //   List collections = ["TVs", "Laptops", "CPUs", "GPUs"];
  //   if (productName.isNotEmpty) {
  //     for (String collection in collections) {
  //       try {
  //         QuerySnapshot snapshot =
  //             await FirebaseFirestore.instance.collection(collection).get();
  //         for (var doc in snapshot.docs) {
  //           final Product product =
  //               Product.fromFirestore(doc.data() as Map<String, dynamic>);
  //           if (product.name == productName) {
  //             print(
  //                 "Found product: ${product.name} in collection: $collection");
  //             return product;
  //           }
  //         }
  //       } catch (e) {
  //         print("Error fetching products from $collection: $e");
  //       }
  //     }
  //   }
  //   // print("product name: $productName");

  //   return null;
  // }

  // Future<Product?> getProduct(
  //     Map<String, dynamic> notifications, int index) async {
  //   String productId = notifications[index]["id"];
  //   String productType = notifications[index]["type"];

  //   if (productId.isNotEmpty && productType.isNotEmpty) {
  //     try {
  //       DocumentSnapshot doc = await FirebaseFirestore.instance
  //           .collection(productType)
  //           .doc(productId)
  //           .get();

  //       if (doc.exists) {
  //         final Product product =
  //             Product.fromFirestore(doc.data() as Map<String, dynamic>);
  //         print("Found product: ${product.name} in collection: $productType");
  //         return product;
  //       } else {
  //         print(
  //             "No product found with ID: $productId in collection: $productType");
  //         return null;
  //       }
  //     } catch (e) {
  //       print("Error fetching product from $productType: $e");
  //       return null;
  //     }
  //   } else {
  //     print("Invalid product ID or type.");
  //     return null;
  //   }
  // }
}
