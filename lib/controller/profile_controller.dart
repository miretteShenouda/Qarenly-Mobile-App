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
    AuthenticationRepo.instance
        .UpdateUser(username.text, email.text, password.text);
  }

  Future<void> deleteUser() async{
    // Delete Firestore user
    await AuthenticationRepo.instance.deleteUser();
    // Delete Firebase Auth user
    await AuthenticationRepo.instance.currentUser!.delete();
  }

  Future<UserModel?> fetchUserData() async {
    return await AuthenticationRepo.instance.fetchUserData();
  }

  void controllerSetters(UserModel user) {
    username.text = username.text.isEmpty ? user.username : username.text;
    email.text = email.text.isEmpty ? user.email : email.text;
    password.text = password.text.isEmpty ? user.password : password.text;
  }
}
