import 'package:flutter/material.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/widgets/custom_elevated_button.dart';
import 'package:qarenly/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class SideMenuScreen extends StatelessWidget {
  SideMenuScreen({Key? key}) : super(key: key);

  TextEditingController homeController = TextEditingController();

  TextEditingController notificationsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.blueGray300,
            resizeToAvoidBottomInset: false,
            body: Container(
                width: 328.h,
                padding: EdgeInsets.symmetric(vertical: 19.v),
                child: Column(children: [
                  SizedBox(height: 14.v),
                  _buildSixtyThree(context),
                  SizedBox(
                    height: 48.v,
                    width: double.infinity,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 5.h, right: 5.h),
                      child: CustomElevatedButton(
                        height: 48.v,
                        width: double.infinity,
                        text: "Home",
                        margin: EdgeInsets.only(
                            left: 25.h, right: 33.h, bottom: 16.v),
                        leftIcon: CustomImageView(
                          imagePath: ImageConstant.imgHome,
                          height: 31.v,
                          width: 28.h,
                        ),
                        onPressed: () {
                          // Handle Home button tap
                        },
                        alignment: Alignment.centerLeft,
                      )),
                  SizedBox(height: 16.v),
                  _buildTen(context),
                  SizedBox(height: 21.v),
                  _buildTwelve(context),
                  SizedBox(height: 21.v),
                  Padding(
                      padding: EdgeInsets.only(left: 5.h, right: 5.h),
                      child: CustomElevatedButton(
                        height: 48.v,
                        width: double.infinity,
                        text: "Notifications",
                        margin: EdgeInsets.only(
                            left: 25.h, right: 33.h, bottom: 16.v),
                        leftIcon: CustomImageView(
                          imagePath: ImageConstant.imgNotificationiconpng91,
                          height: 31.v,
                          width: 28.h,
                        ),
                        onPressed: () {
                          // Handle Home button tap
                        },
                        alignment: Alignment.centerLeft,
                      )),
                  Spacer(),
                  Divider(),
                  SizedBox(height: 19.v),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(left: 21.h),
                          child: Text("About us",
                              style: CustomTextStyles.headlineSmallMedium))),
                  SizedBox(height: 16.v),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(left: 21.h),
                          child: Text("Your account",
                              style: CustomTextStyles.headlineSmallMedium))),
                  SizedBox(height: 19.v),
                  CustomElevatedButton(
                      height: 35.v,
                      width: 145.h,
                      text: "Sign Out",
                      margin: EdgeInsets.only(right: 21.h),
                      leftIcon: Container(
                          margin: EdgeInsets.only(right: 11.h),
                          child: CustomImageView(
                              imagePath: ImageConstant.imgUilsignoutalt,
                              height: 28.v,
                              width: 31.h)),
                      buttonStyle: CustomButtonStyles.fillPrimaryTL17,
                      buttonTextStyle: CustomTextStyles.titleLargeSemiBold,
                      onPressed: () {
                        onTapSignOut(context);
                      },
                      alignment: Alignment.centerRight)
                ]))));
  }

  /// Section Widget
  Widget _buildSixtyThree(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 21.h, right: 12.h),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                  imagePath: ImageConstant.imgEllipse6,
                  height: 91.adaptSize,
                  width: 91.adaptSize,
                  radius: BorderRadius.circular(45.h),
                  margin: EdgeInsets.only(top: 8.v)),
              Padding(
                  padding: EdgeInsets.only(top: 35.v, bottom: 34.v),
                  child: Text("Marie John",
                      style: CustomTextStyles.headlineSmallSemiBold)),
              CustomImageView(
                  imagePath: ImageConstant.imgMobile,
                  height: 37.adaptSize,
                  width: 37.adaptSize,
                  margin: EdgeInsets.only(bottom: 62.v))
            ]));
  }

  /// Section Widget
  Widget _buildTen(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 25.h, right: 33.h),
        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 4.v),
        decoration: AppDecoration.fillOnPrimaryContainer
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder20),
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          CustomImageView(
              imagePath: ImageConstant.imgBookmark,
              height: 24.v,
              width: 17.h,
              margin: EdgeInsets.only(top: 4.v, bottom: 5.v),
              onTap: () {
                onTapImgBookmark(context);
              }),
          Padding(
              padding: EdgeInsets.only(left: 14.h, top: 2.v),
              child: Text("Saved", style: theme.textTheme.headlineSmall))
        ]));
  }

  /// Section Widget
  Widget _buildTwelve(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 25.h, right: 33.h),
        padding: EdgeInsets.symmetric(horizontal: 9.h, vertical: 2.v),
        decoration: AppDecoration.fillOnPrimaryContainer
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder20),
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          CustomImageView(
              imagePath: ImageConstant.imgSolarSettingsLinear,
              height: 25.adaptSize,
              width: 25.adaptSize,
              margin: EdgeInsets.symmetric(vertical: 6.v)),
          Container(
              height: 31.v,
              width: 98.h,
              margin: EdgeInsets.only(left: 5.h, top: 6.v),
              child: Stack(alignment: Alignment.center, children: [
                Align(
                    alignment: Alignment.center,
                    child:
                        Text("Settings", style: theme.textTheme.headlineSmall)),
                Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                        height: 31.v,
                        width: 98.h,
                        child: Stack(alignment: Alignment.center, children: [
                          Align(
                              alignment: Alignment.center,
                              child: Text("Settings",
                                  style: theme.textTheme.headlineSmall)),
                          Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                  height: 31.v,
                                  width: 98.h,
                                  child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Align(
                                            alignment: Alignment.center,
                                            child: Text("Settings",
                                                style: theme
                                                    .textTheme.headlineSmall)),
                                        Align(
                                            alignment: Alignment.center,
                                            child: Text("Settings",
                                                style: theme
                                                    .textTheme.headlineSmall))
                                      ])))
                        ])))
              ]))
        ]));
  }

  /// Navigates to the saveditemsScreen when the action is triggered.
  onTapImgBookmark(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.saveditemsScreen);
  }

  /// Navigates to the loginPageScreen when the action is triggered.
  onTapSignOut(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginPageScreen);
  }
}
