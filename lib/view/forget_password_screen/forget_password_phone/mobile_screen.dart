import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qarenly/controller/authentication_controller/phone_auth_controller.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/view/forget_password_screen/forget_password_OTP/OTP_screen.dart';

class MobileScreen extends StatefulWidget {
  @override
  MobileScreen({Key? key}) : super(key: key);

  @override
  _MobileScreenState createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  PhoneAuthController _controller = Get.put(PhoneAuthController());

  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30 * 4),
              Text("Forgot Password", style: theme.textTheme.displayMedium),
              SizedBox(
                height: 10,
              ),
              Text("Please enter your number to reset your password",
                  style: TextStyle(
                    color: Colors.orange[200],
                  )),
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
                        controller: _controller.phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            label: Text("Mobile Number"),
                            prefixIcon: Icon(Icons.phone)),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              _controller.sendOTP();
                              Get.to(() => const OTPScreen());
                            },
                            child: const Text(
                              "Reset your password",
                              style: TextStyle(color: Colors.black),
                            ))),
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
