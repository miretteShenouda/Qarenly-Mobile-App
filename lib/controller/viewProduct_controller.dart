import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ViewProductController<T> extends GetxController {
  static ViewProductController get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> getProductDetails(
    String productId,
    String productType,
  ) async {
    try {
      print('hel');
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
}
