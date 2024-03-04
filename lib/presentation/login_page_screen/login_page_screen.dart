import 'package:flutter/material.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/common/widgets/custom_elevated_button.dart';
import 'package:qarenly/common/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class LoginPageScreen extends StatelessWidget {
  LoginPageScreen({Key? key}) : super(key: key);

  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
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
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                        key: _formKey,
                        child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.only(
                                left: 19.h, top: 98.v, right: 19.h),
                            child: Column(children: [
                              Container(
                                  decoration: AppDecoration.outlineBlack,
                                  child: Text("Qarenly",
                                      style: theme.textTheme.displayLarge)),
                              SizedBox(height: 68.v),
                              _buildUserName(context),
                              SizedBox(height: 13.v),
                              _buildPassword(context),
                              SizedBox(height: 20.v),
                              _buildLoginButton(context),
                              SizedBox(height: 10.v),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 4.h),
                                      child: Text("forgot your password?",
                                          style: CustomTextStyles.bodyMedium14
                                              .copyWith(
                                                  color: Colors.white,
                                                  decoration: TextDecoration
                                                      .underline)))),
                              SizedBox(height: 23.v),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 110.h),
                                      child: Text("or continue with",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          )))),
                              SizedBox(height: 7.v),
                              _buildGoogleButton(context),
                              SizedBox(height: 8.v),
                              _buildFacebookButton(context),
                              SizedBox(height: 20.v),
                              _buildGuestButton(context),
                              SizedBox(height: 21.v),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                      onTap: () {
                                        onTapTxtDonthaveanaccount(context);
                                      },
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 55.h),
                                          child: RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text:
                                                        "don’t have an account?   ",
                                                    style: theme
                                                        .textTheme.titleMedium),
                                                TextSpan(
                                                    text: "sign up",
                                                    style: theme
                                                        .textTheme.titleMedium!
                                                        .copyWith(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline))
                                              ]),
                                              textAlign: TextAlign.left)))),
                              SizedBox(height: 5.v)
                            ])))))));
  }

  /// Section Widget
  Widget _buildUserName(BuildContext context) {
    return Container(
      height: 39,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.white,
      ),
      child: TextFormField(
          controller: userNameController,
          textInputAction: TextInputAction.done,
          // textInputType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(30.h, 10.v, 26.h, 10.v),
            prefixIcon:
                Icon(Icons.person, color: Colors.orange.withOpacity(0.7)),
            hintText: "Username",
          ),
          obscureText: true),
    );
  }

  /// Section Widget
  Widget _buildPassword(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 10.0), // Adjust vertical margin
      height: 39,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.white,
      ),
      child: TextFormField(
          controller: passwordController,
          textInputAction: TextInputAction.done,
          // textInputType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(30.h, 10.v, 26.h, 10.v),
            prefixIcon: Icon(Icons.lock, color: Colors.orange.withOpacity(0.7)),
            hintText: "Password",
          ),
          obscureText: true),
    );
  }

  /// Section Widget
  Widget _buildLoginButton(BuildContext context) {
    return CustomElevatedButton(
        text: "Login",
        buttonTextStyle: CustomTextStyles.titleLargeBold22,
        onPressed: () {
          onTapLoginButton(context);
        });
  }

  /// Section Widget
  Widget _buildGoogleButton(BuildContext context) {
    return CustomElevatedButton(
        text: "Google",
        leftIcon: Container(
            margin: EdgeInsets.only(right: 20.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgFlatcoloriconsgoogle,
                height: 31.v,
                width: 20.h)));
  }

  /// Section Widget
  Widget _buildFacebookButton(BuildContext context) {
    return CustomElevatedButton(
        text: "Facebook",
        leftIcon: Container(
            margin: EdgeInsets.only(right: 20.h),
            child:
                Icon(Icons.facebook, color: Colors.blue[700]))); // Container(
    // margin: EdgeInsets.only(right: 24.h),
    // child: CustomImageView(
    //     imagePath: ImageConstant.imgLogosfacebook,
    //     height: 28.v,
    //     width: 18.h)));
  }

  /// Section Widget
  Widget _buildGuestButton(BuildContext context) {
    return CustomElevatedButton(
        height: 40.v,
        text: "Enter as a guest",
        margin: EdgeInsets.only(left: 23.h, right: 24.h),
        buttonStyle: CustomButtonStyles.fillPrimaryTL20,
        onPressed: () {
          onTapGuestButton(context);
        });
  }

  /// Navigates to the homepageScreen when the action is triggered.
  onTapLoginButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homepageScreen);
  }

  /// Navigates to the homepageScreen when the action is triggered.
  onTapGuestButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homepageScreen);
  }

  /// Navigates to the signUpPageScreen when the action is triggered.
  onTapTxtDonthaveanaccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signUpPageScreen);
  }
}
