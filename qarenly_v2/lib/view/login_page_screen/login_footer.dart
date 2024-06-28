// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qarenly/common/widgets/api_widget.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:qarenly/common/widgets/api_widget.dart';
import 'package:qarenly/common/widgets/custom_elevated_button.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';
import 'package:get/get.dart';
import 'package:qarenly/view/homepage_screen/homepage_screen.dart';

class LoginFooterWidget extends StatelessWidget {
  // AuthenticationRepo _authController = AuthenticationController();
  AuthenticationRepo _authenticationRepo = Get.put(AuthenticationRepo());
  // const LoginFooterWidget({
  //   Key? key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 20.v),
      CustomElevatedButton(
          height: 40.v,
          text: "Enter as a guest",
          margin: EdgeInsets.only(left: 23.h, right: 24.h),
          buttonStyle: CustomButtonStyles.fillPrimaryTL20,
          onPressed: () async {
            var flag = await _authenticationRepo.enterAsGuest();
            if (flag) {
              Navigator.pushNamed(context, AppRoutes.homepageScreen);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Failed to enter as guest"),
                ),
              );
            }
          }),
      Align(
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.signUpPageScreen);
            },
            child: const Text.rich(TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(color: Color.fromARGB(255, 5, 30, 69)),
                children: [
                  TextSpan(
                      text: "Sign up",
                      style: TextStyle(
                          color: Color.fromARGB(255, 5, 30, 69),
                          fontWeight: FontWeight.bold))
                ])),
          )),
      SizedBox(height: 10),
      ApiButton(
        text: "Google",
        img: ImageConstant.imgGoogle,
        onPressed: () async {
          User? user = await _authenticationRepo.signInWithGoogle();
          if (user != null) {
            // Navigate to the next screen or do something with the signed-up user
            Get.offAll(() => HomepageScreen(user));
          } else {
            // Handle sign-up failure
            print("failed");
          }
        },
      ),
      SizedBox(height: 10),
      ApiButton(
        text: "Facebook",
        img: ImageConstant.imgLogosfacebook,
        onPressed: () {
          _authenticationRepo.signUpWithFacebook(context);
        },
      ),
    ]);
  }
}
