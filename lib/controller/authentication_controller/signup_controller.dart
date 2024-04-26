import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  void registerUser(String email, String password) async {
    User? user = await AuthenticationRepo.instance
        .createUserWithEmailAndPassword(email, password);
    InsertUser(user);
  }

  void InsertUser(User? user) async {
    AuthenticationRepo.instance
        .InsertUser(user, username.text, email.text, password.text);
  }
}
