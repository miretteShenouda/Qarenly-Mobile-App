import 'package:flutter/material.dart';
import 'package:qarenly/view/sign_up_page_screen/tff_widget.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
    required this.userNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  }) : super(key: key);

  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        TFF_widget(
          userNameController: userNameController,
          labelText: "Username",
          ticon: Icons.person,
        ),
        SizedBox(
          height: 10,
        ),
        TFF_widget(
            userNameController: emailController,
            labelText: "e-mail",
            ticon: Icons.email_outlined),
        SizedBox(
          height: 10,
        ),
        TFF_widget(
          userNameController: passwordController,
          labelText: "Password",
          ticon: Icons.fingerprint,
        ),
        SizedBox(
          height: 10,
        ),
        TFF_widget(
          userNameController: confirmPasswordController,
          labelText: "Confirm Password",
          ticon: Icons.fingerprint,
        ),
      ],
    ));
  }
}
