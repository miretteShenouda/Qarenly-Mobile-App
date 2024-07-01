import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';

class NotificationController extends GetxController {
  static NotificationController get instance => Get.find();
  AuthenticationRepo _authenticationRepo = Get.put(AuthenticationRepo());
  RxList<Map<String, dynamic>> notifications = <Map<String, dynamic>>[].obs;
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
    if (_authenticationRepo.currentUser!.isAnonymous) {
      return;
    }

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
}
