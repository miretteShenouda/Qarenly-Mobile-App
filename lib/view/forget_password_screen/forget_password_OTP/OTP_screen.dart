import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:qarenly/controller/authentication_controller/phone_auth_controller.dart';
import 'package:get/get.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  PhoneAuthController _controller = Get.put(PhoneAuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "CO\nDE",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                "verification".toUpperCase(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 40.0),
              const Text("Enter the code was sent to you",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(height: 20.0),
              OtpTextField(
                  mainAxisAlignment: MainAxisAlignment.center,
                  numberOfFields: 6,
                  fillColor: Colors.black.withOpacity(0.1),
                  filled: true,
                  onSubmit: (code) {
                    _controller.otpController = code as TextEditingController;
                    print("OTP is => {$code}");
                  }),
              SizedBox(height: 20.0),
              SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      _controller.verifyOTP();
                    },
                    child:
                        Text("Submit", style: TextStyle(color: Colors.black)),
                  )),
            ],
          )),
    );
  }
}
