import 'package:flutter/material.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/common/widgets/custom_elevated_button.dart';
import 'package:qarenly/presentation/forget_password_screen/forget_password_option/modal_bottom_sheet.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required this.userNameController,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController userNameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(children: [
      Container(
        height: 39,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: Colors.white,
        ),
        child: TextFormField(
          controller: userNameController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: "E-mail",
            labelText: "Username",
            contentPadding: EdgeInsets.fromLTRB(30.h, 10.v, 26.h, 10.v),
            prefixIcon:
                Icon(Icons.person, color: Colors.orange.withOpacity(0.8)),
          ),
        ),
      ),
      // End of the section

      SizedBox(height: 13.v),

      //start of passwrod section
      Container(
        height: 39,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: Colors.white,
        ),
        child: TextFormField(
          controller: passwordController,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
              hintText: "Password",
              labelText: "Password",
              contentPadding: EdgeInsets.fromLTRB(30.h, 10.v, 26.h, 10.v),
              prefixIcon:
                  Icon(Icons.lock, color: Colors.orange.withOpacity(0.7)),
              suffixIcon: IconButton(
                  onPressed: null, icon: Icon(Icons.remove_red_eye_outlined))),
        ),
      ),
      // End of the section

      SizedBox(height: 20.v),

      //start of login button section
      CustomElevatedButton(
        text: "Login",
        buttonTextStyle: CustomTextStyles.titleLargeBold22,
        onPressed: () {
          // LoginAuthfunction(username, password);
        },
      ),
      // end of the section

      SizedBox(height: 10.v),
      // forget your passwrod section
      Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(left: 4.h),
              child: TextButton(
                onPressed: () {
                  ForgetPasswordScreen.showModalSheet(context);
                },
                child: Text("forgot your password?"),
              ))),
      // End of the section
    ]));
  }
}
