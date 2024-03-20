import 'package:flutter/material.dart';
import 'package:qarenly/core/app_export.dart';

class MobileScreen extends StatelessWidget {
  const MobileScreen({Key? key}) : super(key: key);

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
                height: 10,
              ),
              Text("Please enter your phone number to reset your password",
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
                              //Get.to();
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
