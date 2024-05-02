import 'package:flutter/material.dart';
import 'package:qarenly/view/forget_password_screen/forget_password_option/password_button.dart';
import 'package:qarenly/view/forget_password_screen/forget_password_mail/mail_screen.dart';
import 'package:qarenly/view/forget_password_screen/forget_password_phone/mobile_screen.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen {
  static Future<dynamic> showModalSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: (context) => Container(
        padding: EdgeInsets.all(30.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Make a selection!!",
              style: Theme.of(context).textTheme.headlineMedium),
          Text("Select one of the given options below to reset your password",
              style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(height: 20),
          ForgetPasswordWidget(
            buttonIcon: Icons.email_outlined,
            title: "Email",
            subTitle: "Reset via E-mail",
            ontap: () {
              Navigator.pop(context);
              Get.to(() => const MailScreen());
            },
          ),
          SizedBox(height: 20),
          ForgetPasswordWidget(
            buttonIcon: Icons.mobile_screen_share,
            title: "Mobile",
            subTitle: "Reset via your mobile phone number",
            ontap: () {
              Navigator.pop(context);
              Get.to(() => MobileScreen());
            },
          ),
        ]),
      ),
    );
  }
}
