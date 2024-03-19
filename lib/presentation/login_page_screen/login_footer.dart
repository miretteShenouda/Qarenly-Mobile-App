import 'package:flutter/material.dart';
import 'package:qarenly/common/widgets/custom_elevated_button.dart';
import 'package:qarenly/core/app_export.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(left: 110.h),
              child: Text("or continue with",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  )))),
      SizedBox(height: 7.v),

      // start of google login section
      CustomElevatedButton(
          text: "Google",
          onPressed: null,
          leftIcon: Container(
              margin: EdgeInsets.only(right: 20.h),
              child: CustomImageView(
                  imagePath: ImageConstant.imgFlatcoloriconsgoogle,
                  height: 31.v,
                  width: 20.h))),
      // end of the section

      SizedBox(height: 8.v),

      // start of facebook section
      CustomElevatedButton(
          text: "Facebook",
          onPressed: null,
          leftIcon: Container(
              margin: EdgeInsets.only(right: 20.h),
              child: Icon(Icons.facebook, color: Colors.blue[700]))),
      // end of the section

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
            onPressed: () {},
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
