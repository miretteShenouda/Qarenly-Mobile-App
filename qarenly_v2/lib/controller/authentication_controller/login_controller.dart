import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:intl/number_symbols_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  late User? currentUser;
  bool loggedIn = false;
  bool isObscure = true;

  Future<bool> loginUser(String email, String password) async {
    loggedIn = await AuthenticationRepo.instance
        .loginWithEmailAndPassword(email, password);
    currentUser = AuthenticationRepo.instance.currentUser;
    // print(currentUser!.email);
    return loggedIn;
  }
}
