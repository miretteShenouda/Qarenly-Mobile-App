import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';

class PhoneAuthController extends GetxController {
  static PhoneAuthController get instance => Get.find();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String verificationId = '';

  Future<void> sendOTP() async {
    String phoneNumber = phoneNumberController.text.trim();
    AuthenticationRepo.instance.sendOTP(phoneNumber);
  }

  Future<void> verifyOTP() async {
    String otp = otpController.text.trim();
    AuthenticationRepo.instance.verifyOTP(otp, verificationId);
  }
}
