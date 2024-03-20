import 'package:flutter/material.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:get/get.dart';
import 'package:qarenly/presentation/forget_password_screen/forget_password_OTP/OTP_screen.dart';

class MailScreen extends StatelessWidget {
  const MailScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: SizeUtils.width,
      height: SizeUtils.height,
      // decoration of the color ballet "background"
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
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30 * 4),
              Text("Forgot Password", style: theme.textTheme.displayMedium),
              SizedBox(
                height: 5,
              ),
              Text("Please enter your mail to reset your password",
                  style: TextStyle(
                    color: Colors.orange[200],
                  )
                  //theme.textTheme.bodyLarge,

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
                        decoration: const InputDecoration(
                            label: Text("Email"),
                            hintText: "Email",
                            prefixIcon: Icon(Icons.mail_outline_rounded)),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => const OTPScreen());
                            },
                            child: const Text("Reset your password"))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
