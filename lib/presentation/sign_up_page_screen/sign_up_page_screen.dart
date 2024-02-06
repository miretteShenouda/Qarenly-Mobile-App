import 'package:flutter/material.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:qarenly/widgets/app_bar/custom_app_bar.dart';
import 'package:qarenly/widgets/custom_elevated_button.dart';
import 'package:qarenly/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class SignUpPageScreen extends StatelessWidget {
  SignUpPageScreen({Key? key}) : super(key: key);

  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 17.h, vertical: 51.v),
                            child: Column(children: [
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                      height: 141.v,
                                      width: 308.h,
                                      child: Stack(
                                          alignment: Alignment.bottomLeft,
                                          children: [
                                            Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                    width: 291.h,
                                                    decoration: AppDecoration
                                                        .outlineBlack,
                                                    child: Text("Qarenly",
                                                        maxLines: null,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: theme.textTheme
                                                            .displayLarge))),
                                            Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Text("Create account",
                                                    style: theme.textTheme
                                                        .displaySmall))
                                          ]))),
                              SizedBox(height: 22.v),
                              _buildUserName(context),
                              SizedBox(height: 12.v),
                              _buildEmail(context),
                              SizedBox(height: 11.v),
                              _buildPassword(context),
                              SizedBox(height: 11.v),
                              _buildConfirmPassword(context),
                              SizedBox(height: 26.v),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 102.h),
                                      child: Text("or continue with",
                                          style: theme.textTheme.bodyLarge))),
                              SizedBox(height: 7.v),
                              _buildGoogleButton(context),
                              SizedBox(height: 8.v),
                              _buildFacebookButton(context),
                              SizedBox(height: 21.v),
                              _buildRegisterButton(context),
                              SizedBox(height: 5.v)
                            ])))))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: double.maxFinite,
        leading: AppbarLeadingIconbutton(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.fromLTRB(20.h, 5.v, 317.h, 5.v),
            onTap: () {
              onTapArrowLeft(context);
            }));
  }

  /// Section Widget
  Widget _buildUserName(BuildContext context) {
    return CustomTextFormField(
        controller: userNameController,
        hintText: "Username",
        prefix: Container(
            margin: EdgeInsets.fromLTRB(29.h, 4.v, 20.h, 3.v),
            child: CustomImageView(
                imagePath: ImageConstant.imgEiuserErrorcontainer,
                height: 39.v,
                width: 40.h)),
        prefixConstraints: BoxConstraints(maxHeight: 46.v));
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return CustomTextFormField(
        controller: emailController,
        hintText: "Email",
        textInputType: TextInputType.emailAddress,
        prefix: Container(
            margin: EdgeInsets.fromLTRB(30.h, 13.v, 27.h, 13.v),
            child: CustomImageView(
                imagePath: ImageConstant.imgEmail, height: 18.v, width: 21.h)),
        prefixConstraints: BoxConstraints(maxHeight: 46.v));
  }

  /// Section Widget
  Widget _buildPassword(BuildContext context) {
    return CustomTextFormField(
        controller: passwordController,
        hintText: "Password",
        textInputType: TextInputType.visiblePassword,
        prefix: Container(
            margin: EdgeInsets.fromLTRB(30.h, 10.v, 26.h, 10.v),
            child: CustomImageView(
                imagePath: ImageConstant.imgLocation,
                height: 24.v,
                width: 22.h)),
        prefixConstraints: BoxConstraints(maxHeight: 46.v),
        obscureText: true);
  }

  /// Section Widget
  Widget _buildConfirmPassword(BuildContext context) {
    return CustomTextFormField(
        controller: confirmPasswordController,
        hintText: "Confirm Password",
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
        prefix: Container(
            margin: EdgeInsets.fromLTRB(30.h, 10.v, 18.h, 10.v),
            child: CustomImageView(
                imagePath: ImageConstant.imgLocation,
                height: 24.v,
                width: 22.h)),
        prefixConstraints: BoxConstraints(maxHeight: 46.v),
        obscureText: true);
  }

  /// Section Widget
  Widget _buildGoogleButton(BuildContext context) {
    return CustomElevatedButton(
        text: "Google",
        leftIcon: Container(
            margin: EdgeInsets.only(right: 29.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgFlatcoloriconsgoogle,
                height: 31.v,
                width: 29.h)));
  }

  /// Section Widget
  Widget _buildFacebookButton(BuildContext context) {
    return CustomElevatedButton(
        text: "Facebook",
        leftIcon: Container(
            margin: EdgeInsets.only(right: 24.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgLogosfacebook,
                height: 31.v,
                width: 29.h)));
  }

  /// Section Widget
  Widget _buildRegisterButton(BuildContext context) {
    return CustomElevatedButton(
        height: 40.v,
        text: "Register",
        margin: EdgeInsets.only(left: 24.h, right: 25.h),
        buttonStyle: CustomButtonStyles.fillPrimaryTL20,
        buttonTextStyle: CustomTextStyles.titleLargeBold,
        onPressed: () {
          onTapRegisterButton(context);
        });
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the homepageScreen when the action is triggered.
  onTapRegisterButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homepageScreen);
  }
}
