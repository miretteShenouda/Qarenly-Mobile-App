import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qarenly/core/app_export.dart';

class MailScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.5, 0),
            end: Alignment(0.5, 1),
            colors: [
              theme.colorScheme.onPrimary,
              appTheme.teal100Ec,
              theme.colorScheme.primary.withOpacity(0.93),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30 * 4),
                Text("Forgot Password", style: theme.textTheme.displayMedium),
                SizedBox(height: 5),
                Text(
                  "Please enter your email to reset your password",
                  style: TextStyle(
                    color: Colors.orange[200],
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            label: Text("Email"),
                            hintText: "Email",
                            prefixIcon: Icon(Icons.mail_outline_rounded),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final email = _emailController.text;
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: email);
                            Get.snackbar(
                              "Reset Link Sent",
                              "A password reset link has been sent to $email",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.loginPageScreen);
                          },
                          child: const Text(
                            "Reset your password",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
