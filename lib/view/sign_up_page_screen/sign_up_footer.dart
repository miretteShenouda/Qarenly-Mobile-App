import 'package:flutter/material.dart';
import 'package:qarenly/common/widgets/api_widget.dart';
import 'package:qarenly/controller/authentication_controller/authentication_controller.dart';
import 'package:qarenly/core/app_export.dart';

class signUpFooter extends StatelessWidget {
  AuthenticationController _authController = AuthenticationController();
  // const signUpFooter({
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
      SizedBox(height: 10),
      ApiButton(
        text: "Google",
        img: ImageConstant.imgGoogle,
        onPressed: () {},
      ),
      SizedBox(height: 10),
      ApiButton(
        text: "Facebook",
        img: ImageConstant.imgLogosfacebook,
        onPressed: () {
          _authController.signUpWithFacebook(context);
        },
      ),
      SizedBox(height: 20),
    ]);
  }
}
