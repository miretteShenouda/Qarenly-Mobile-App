import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  void updateProfile() {
    AuthenticationRepo.instance
        .UpdateUser(username.text, email.text, password.text);
  }
}
