import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';

class NotificationController extends GetxController {
  static NotificationController get instance => Get.find();
  AuthenticationRepo _authenticationRepo = Get.put(AuthenticationRepo());

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
}