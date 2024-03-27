import 'package:flutter/material.dart';
import 'package:qarenly/controller/authentication_controller/login_controller.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/common/widgets/custom_elevated_button.dart';
import 'package:qarenly/view/forget_password_screen/forget_password_option/modal_bottom_sheet.dart';
import 'package:get/get.dart';

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
    final controller = Get.put(LoginController());
    final _formkey = GlobalKey<FormState>();

    return Form(
        key: _formkey,
        child: Column(children: [
          Container(
            height: 39,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.white,
            ),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email address.';
                } else if (!value.contains('@')) {
                  return 'Please enter a valid email address.';
                }
                return null;
              },
              controller: controller.email,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "E-mail",
                contentPadding: EdgeInsets.fromLTRB(30.h, 10.v, 26.h, 10.v),
                prefixIcon:
                    Icon(Icons.person, color: Colors.orange.withOpacity(0.8)),
              ),
            ),
          ),

          SizedBox(height: 13.v),

          Container(
            height: 39,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.white,
            ),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password.';
                }
                return null;
              },
              controller: controller.password,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  hintText: "Password",
                  labelText: "Password",
                  contentPadding: EdgeInsets.fromLTRB(30.h, 10.v, 26.h, 10.v),
                  prefixIcon:
                      Icon(Icons.lock, color: Colors.orange.withOpacity(0.7)),
                  suffixIcon: IconButton(
                      onPressed: null,
                      icon: Icon(Icons.remove_red_eye_outlined))),
            ),
          ),

          SizedBox(height: 20.v),

          CustomElevatedButton(
            text: "Login",
            buttonTextStyle: CustomTextStyles.titleLargeBold22,
            onPressed: () {
              if (_formkey.currentState!.validate()) {
                LoginController.instance.loginUser(controller.email.text.trim(),
                    controller.password.text.trim());
              }
            },
          ),

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
        ]));
  }
}
