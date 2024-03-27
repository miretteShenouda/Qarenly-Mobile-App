import 'package:flutter/material.dart';
import 'package:qarenly/common/widgets/api_widget.dart';
import 'package:qarenly/core/app_export.dart';

class signUpFooter extends StatelessWidget {
  const signUpFooter({
    Key? key,
  }) : super(key: key);

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
      ApiButton(text: "Google", img: ImageConstant.imgGoogle),
    ]);
  }
}
