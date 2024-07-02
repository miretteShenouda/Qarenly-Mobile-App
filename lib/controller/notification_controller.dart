import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
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
    if (_authenticationRepo.userData!.notificationToken != null) {
      return true;
    }

    return false;
  }

  Future<void> generateToken() async {
    _authenticationRepo.userData!.notificationToken =
        await FirebaseMessaging.instance.getToken();
  }

  void validateToken() async {
    if (_authenticationRepo.currentUser!.isAnonymous) {
      return;
    }

    _authenticationRepo.userData = await _authenticationRepo.fetchUserData();
    bool bValue = !existToken();
    if (bValue) {
      await generateToken();
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
}
