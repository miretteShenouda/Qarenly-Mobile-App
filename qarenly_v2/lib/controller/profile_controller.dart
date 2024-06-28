import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qarenly/model/user_model.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool passwordIsObsecure = true;
  TextEditingController confirmPassword = TextEditingController();
  bool passwordConfirmIsObsecure = true;

  void updateProfile() {
    UserModel user = AuthenticationRepo.instance.userData!;
    user.username = username.text;
    user.email = email.text;
    user.password = password.text;
    AuthenticationRepo.instance.UpdateUser(user);
    AuthenticationRepo.instance.updateUserPassword(password.text);
  }

  Future<void> deleteUser() async {
    // Delete Firestore user
    await AuthenticationRepo.instance.deleteUser();
    // Delete Firebase Auth user
    await AuthenticationRepo.instance.currentUser!.delete();
    AuthenticationRepo.instance.userData = null;
  }

  Future<UserModel?> fetchUserData() async {
    UserModel? user = await AuthenticationRepo.instance.fetchUserData();
    controllerSetters(user!);
    AuthenticationRepo.instance.userData = user;
    return user;
  }

  void controllerSetters(UserModel user) {
    username.text = user.username;
    email.text = user.email;
    password.text = user.password;
  }
}
