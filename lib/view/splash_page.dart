import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

 @override
    void initState() {
        super.initState();
        Timer(Duration(seconds: 1), () {
          Get.put(AuthenticationRepo());
        });
    }

@override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            body: Center(
                child: Image.asset('assets/images/qarenly_logo.png'),
            ),
        );
    }
}