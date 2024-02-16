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
                      leftIcon: Padding(
                        padding: EdgeInsets.only(right: 15.h, left: 0.h),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgHome,
                          height: 31.v,
                          width: 28.h,
                          // alignment: Alignment
                          //     .centerLeft, // Align icon to the leftmost
                          margin: EdgeInsets.only(top: 4.v, bottom: 5.v),
                        ),
                      ),
                      onPressed: () {
                        // Handle Home button tap
                      },
                      alignment: Alignment
                          .centerLeft, // Align button content to the left
                    ),
                  ),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                //  crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      // Handle About Us button tap
                                    },
                                    child: Text(
                                      "About Us",
                                      style: CustomTextStyles
                                          .headlineSmallMedium
                                          .copyWith(color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(height: 8.v),
                                  TextButton(
                                    onPressed: () {
                                      // Handle Your Account button tap
                                    },
                                    child: Text(
                                      "Your Account",
                                      style: CustomTextStyles
                                          .headlineSmallMedium
                                          .copyWith(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ))),
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
    return CustomElevatedButton(
      height: 48.v,
      width: double.infinity,
      text: "Saved",
      margin: EdgeInsets.only(left: 25.h, right: 33.h, bottom: 16.v),
      leftIcon: CustomImageView(
        imagePath: ImageConstant.imgBookmark,
        height: 24.v,
        width: 17.h,
        margin: EdgeInsets.only(right: 14.h),
        alignment: Alignment.centerLeft, // Align the image to the leftmost
      ),
      onPressed: () {
        onTapImgBookmark(context);
      },
      alignment: Alignment.centerLeft, // Align the button content to the left
    );
  }

  /// Section Widget
  Widget _buildTwelve(BuildContext context) {
    return Padding(
      //margin: EdgeInsets.only(left: 25.h, right: 33.h),
      padding: EdgeInsets.only(left: 25.h, right: 33.h),
      child: CustomElevatedButton(
        height: 48.v,
        width: double.infinity,
        text: "Settings",
        margin: EdgeInsets.only(bottom: 16.v),
        leftIcon: CustomImageView(
          imagePath: ImageConstant.imgSolarSettingsLinear,
          height: 25.adaptSize,
          width: 25.adaptSize,
          margin: EdgeInsets.only(right: 14.h),
        ),
        onPressed: () {
          // Handle Settings button tap
          // You can navigate to the settings screen or perform any action here
        },
        alignment: Alignment.centerLeft,
      ),
    );
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
