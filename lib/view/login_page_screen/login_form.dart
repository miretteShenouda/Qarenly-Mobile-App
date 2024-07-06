import 'package:flutter/material.dart';
import 'package:qarenly/controller/authentication_controller/login_controller.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/common/widgets/custom_elevated_button.dart';
import 'package:qarenly/view/forget_password_screen/forget_password_option/modal_bottom_sheet.dart';
import 'package:get/get.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.userNameController,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController userNameController;
  final TextEditingController passwordController;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final _formkey = GlobalKey<FormState>();

    return Form(
        key: _formkey,
        child: Column(children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email address.';
              } else if (!value.contains('@') && !value.contains('.')) {
                return 'Please enter a valid email address.';
              }
              return null;
            },
            controller: controller.email,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: "Email",
              contentPadding: EdgeInsets.fromLTRB(30.h, 10.v, 26.h, 10.v),
              prefixIcon:
                  Icon(Icons.person, color: Colors.orange.withOpacity(0.8)),
            ),
          ),

          SizedBox(height: 13.v),

          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password.';
              } else if (value.length < 6) {
                return 'Password must be at least 6 characters long.';
              }
              return null;
            },
            obscureText: controller.isObscure,
            controller: controller.password,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Password",
                contentPadding: EdgeInsets.fromLTRB(30.h, 10.v, 26.h, 10.v),
                prefixIcon:
                    Icon(Icons.lock, color: Colors.orange.withOpacity(0.7)),
                suffixIcon: IconButton(
                    onPressed: () {
                      controller.isObscure = !controller.isObscure;
                      setState(() {});
                    },
                    icon: controller.isObscure
                        ? Icon(Icons.remove_red_eye)
                        : Icon(Icons.remove_red_eye_outlined))),
          ),

          SizedBox(height: 20.v),

          CustomElevatedButton(
            text: "Login",
            buttonTextStyle: CustomTextStyles.titleLargeBold22,
            onPressed: () async {
              if (_formkey.currentState!.validate()) {
                controller.loggedIn = await controller.loginUser(
                    controller.email.text.trim(),
                    controller.password.text.trim());
                if (controller.loggedIn) {
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.homepageScreen);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Invalid email or password'),
                  ));
                }
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
