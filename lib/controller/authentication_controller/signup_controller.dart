import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qarenly/model/user_model.dart';
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

    UserModel userModel = UserModel(
        id: user!.uid,
        username: username.text,
        email: email,
        password: password,
    );

    InsertUser(userModel);
  }

  void InsertUser(UserModel user) async {
    AuthenticationRepo.instance
        .InsertUser(user);
  }
}
