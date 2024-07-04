import 'package:flutter/material.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/view/sign_up_page_screen/sign_up_footer.dart';
import 'package:qarenly/view/sign_up_page_screen/sign_up_form.dart';

class SignUpPageScreen extends StatelessWidget {
  SignUpPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      width: SizeUtils.width,
      height: SizeUtils.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(0.5, 0),
              end: Alignment(0.5, 1),
              colors: [
            theme.colorScheme.onPrimary,
            appTheme.teal100Ec,
            theme.colorScheme.primary.withOpacity(0.93)
          ])),
      child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 25.0),
          child: Column(
            children: [
              Text("Qarenly", style: theme.textTheme.displayLarge),
              SizedBox(
                height: 50,
              ),
              Text("Create Account",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 30,
                  )),
              SizedBox(
                height: 10,
              ),
              SignUpForm(),
              SizedBox(
                height: 30,
              ),
              signUpFooter(),
            ],
          )),
    )));
  }
}
