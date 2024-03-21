import 'package:flutter/material.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/view/login_page_screen/login_form.dart';
import 'package:qarenly/view/login_page_screen/login_footer.dart';

class LoginPageScreen extends StatefulWidget {
  @override
  LoginPageScreen({Key? key}) : super(key: key);

  @override
  _LoginPageScreenState createState() => _LoginPageScreenState();
}

// ignore_for_file: must_be_immutable
class _LoginPageScreenState extends State<LoginPageScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
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
                        width: double.maxFinite,
                        padding:
                            EdgeInsets.only(left: 19.h, top: 98.v, right: 19.h),
                        child: Column(children: [
                          // The page Header section
                          Container(
                              decoration: AppDecoration.outlineBlack,
                              child: Text("Qarenly",
                                  style: theme.textTheme.displayLarge)),
                          // End of the section

                          SizedBox(height: 68.v),

                          //LoginForm section
                          LoginForm(
                              userNameController: userNameController,
                              passwordController: passwordController),
                          SizedBox(height: 23.v),

                          //LoginFooter section
                          LoginFooterWidget(),
                          SizedBox(height: 5.v)
                        ]))))));
  }
}
