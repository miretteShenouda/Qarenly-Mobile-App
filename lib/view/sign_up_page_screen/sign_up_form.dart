import 'package:flutter/material.dart';
import 'package:qarenly/common/theme/custom_text_style.dart';
import 'package:qarenly/common/widgets/custom_elevated_button.dart';
import 'package:qarenly/controller/authentication_controller/signup_controller.dart';
import 'package:qarenly/view/sign_up_page_screen/tff_widget.dart';
import 'package:get/get.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formkey = GlobalKey<FormState>();

    return Form(
        key: _formkey,
        child: Column(
          children: [
            TFF_widget(
              Controller: controller.username,
              labelText: "Username",
              ticon: Icons.person,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username.';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TFF_widget(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email address.';
                  } else if (!value.contains('@')) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
                Controller: controller.email,
                labelText: "e-mail",
                ticon: Icons.email_outlined),
            SizedBox(
              height: 10,
            ),
            TFF_widget(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password.';
                } else if (value.length < 6) {
                  return 'Password must be at least 6 characters long.';
                }
                return null;
              },
              Controller: controller.password,
              labelText: "Password",
              ticon: Icons.fingerprint,
            ),
            SizedBox(
              height: 10,
            ),
            TFF_widget(
              validator: (value) {
                if (value != controller.password.text) {
                  return 'Passwords do not match.';
                }
                return null;
              },
              Controller: controller.confirmPassword,
              labelText: "Confirm Password",
              ticon: Icons.fingerprint,
            ),
            SizedBox(
              height: 10,
            ),
            CustomElevatedButton(
              text: "Register",
              buttonTextStyle: CustomTextStyles.titleLargeBold22,
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  SignUpController.instance.registerUser(
                      controller.email.text.trim(),
                      controller.password.text.trim());
                }
              },
            ),
          ],
        ));
  }
}