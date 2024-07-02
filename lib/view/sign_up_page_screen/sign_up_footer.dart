import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qarenly/common/widgets/api_widget.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';
import 'package:get/get.dart';
import 'package:qarenly/view/homepage_screen/homepage_screen.dart';

class signUpFooter extends StatelessWidget {
  AuthenticationRepo _authenticationRepo = Get.put(AuthenticationRepo());

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(left: 110.h),
              child: Text("or continue with",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 15,
                  )))),
      SizedBox(height: 10),
      ApiButton(
        text: "Google",
        img: ImageConstant.imgGoogle,
        onPressed: () async {
          User? user = await _authenticationRepo.signInWithGoogle();
          if (user != null) {
            Get.offAll(() => HomepageScreen(user));
          } else {
            // Handle sign-up failure
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
      SizedBox(height: 20),
    ]);
  }
}
