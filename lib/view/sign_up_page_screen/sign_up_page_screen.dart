import 'package:flutter/material.dart';
import 'package:qarenly/common/widgets/api_widget.dart';
// import 'package:qarenly/common/widgets/custom_elevated_button.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/view/sign_up_page_screen/sign_up_footer.dart';
import 'package:qarenly/view/sign_up_page_screen/sign_up_form.dart';
// import 'package:qarenly/view/sign_up_page_screen/tff_widget.dart';
// import 'package:qarenly/common/widgets/app_bar/appbar_leading_iconbutton.dart';
// import 'package:qarenly/common/widgets/app_bar/custom_app_bar.dart';
// import 'package:qarenly/common/widgets/custom_elevated_button.dart';

class SignUpPageScreen extends StatelessWidget {
  SignUpPageScreen({Key? key}) : super(key: key);

  // TextEditingController userNameController = TextEditingController();

  // TextEditingController emailController = TextEditingController();

  // TextEditingController passwordController = TextEditingController();

  // TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      width: SizeUtils.width,
      height: SizeUtils.height,
      // Decoration of the background
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
