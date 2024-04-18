import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:qarenly/common/widgets/api_widget.dart';
import 'package:qarenly/common/widgets/custom_elevated_button.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';

class LoginFooterWidget extends StatelessWidget {
  // AuthenticationRepo _authController = AuthenticationController();
  AuthenticationRepo _authenticationRepo = AuthenticationRepo();
  // const LoginFooterWidget({
  //   Key? key,
  // }) : super(key: key);

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
      SizedBox(height: 7.v),

      ApiButton(
        text: "Google",
        img: ImageConstant.imgGoogle,
        onPressed: () {},
      ),

      SizedBox(height: 8.v),

      // start of facebook section
      ApiButton(
        text: "Facebook",
        img: ImageConstant.imgLogosfacebook,
        onPressed: () {
          _authenticationRepo.loginWithFacebook(context);
        },
      ),

      SizedBox(height: 20.v),

      // start of guest section
      CustomElevatedButton(
          height: 40.v,
          text: "Enter as a guest",
          margin: EdgeInsets.only(left: 23.h, right: 24.h),
          buttonStyle: CustomButtonStyles.fillPrimaryTL20,
          onPressed: () {}),
      // endt of the section

      Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.signUpPageScreen);
            },
            child: const Text.rich(TextSpan(
                text: "Don't have an account?",
                style: TextStyle(color: Color.fromARGB(255, 5, 30, 69)),
                children: [
                  TextSpan(
                      text: "Sign up",
                      style: TextStyle(
                          color: Color.fromARGB(255, 5, 30, 69),
                          fontWeight: FontWeight.bold))
                ])),
          )),
    ]);
  }
}
