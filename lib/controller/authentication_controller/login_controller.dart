import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  void loginUser(String email, String password) {
    AuthenticationRepo.instance.loginWithEmailAndPassword(email, password);
  }
}
