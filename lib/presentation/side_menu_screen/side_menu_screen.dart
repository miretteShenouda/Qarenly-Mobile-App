import 'package:flutter/material.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable
class SideMenuScreen extends StatelessWidget {
  SideMenuScreen({Key? key}) : super(key: key);

  TextEditingController homeController = TextEditingController();

  TextEditingController notificationsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.blueGray300,
      body: Row(
        children: [
          // Side Menu (Drawer)
          Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: appTheme.blueGray300,
                  ),
                  child: _buildSixtyThree(context),
                ),
                ListTile(
                  title: Text(
                    'Home',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 6, 51, 89),
                      fontSize: 20,
                    ),
                  ),
                  leading: CustomImageView(
                    imagePath: ImageConstant.imgHome,
                    height: 31.v,
                    width: 28.h,
                  ),
                  onTap: () {
                    onTapImgHome(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Saved',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 6, 51, 89),
                      fontSize: 20,
                    ),
                  ),
                  leading: CustomImageView(
                    imagePath: ImageConstant.imgBookmark,
                    height: 24.v,
                    width: 17.h,
                  ),
                  onTap: () {
                    // Handle Saved onTap
                  },
                ),
                ListTile(
                  title: Text(
                    'Notifications',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 6, 51, 89),
                      fontSize: 20,
                    ),
                  ),
                  leading: CustomImageView(
                    imagePath: ImageConstant.imgNotificationiconpng91,
                    height: 24.v,
                    width: 17.h,
                  ),
                  onTap: () {
                    // Handle Saved onTap
                  },
                ),
                ListTile(
                  title: Text(
                    'Settings',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 6, 51, 89),
                      fontSize: 20,
                    ),
                  ),
                  leading: CustomImageView(
                    imagePath: ImageConstant.imgSolarSettingsLinear,
                    height: 25.adaptSize,
                    width: 25.adaptSize,
                  ),
                  onTap: () {
                    // Handle Settings onTap
                  },
                ),
                ListTile(
                  title: Text(
                    'About Us',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 6, 51, 89),
                      fontSize: 20,
                    ),
                  ),
                  leading: CustomImageView(
                    imagePath: ImageConstant.aboutUs,
                    height: 25.adaptSize,
                    width: 25.adaptSize,
                  ),
                  onTap: () {
                    // Handle About Us onTap
                  },
                ),
                SizedBox(height: 16.v),
                Spacer(),
                Divider(),
                SizedBox(height: 16.v),
                ListTile(
                  title: Text(
                    'Dark mode',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 6, 51, 89),
                      fontSize: 20,
                    ),
                  ),
                  leading: CustomImageView(
                    imagePath: ImageConstant.nightmode,
                    height: 33.v,
                    width: 33.h,
                  ),
                  onTap: () {
                    onTapSignOut(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Sign Out',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 6, 51, 89),
                      fontSize: 20,
                    ),
                  ),
                  leading: CustomImageView(
                    imagePath: ImageConstant.imgUilsignoutalt,
                    height: 33.v,
                    width: 33.h,
                  ),
                  onTap: () {
                    onTapSignOut(context);
                  },
                ),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: Container(
              width: 328.h,
              padding: EdgeInsets.symmetric(vertical: 19.v, horizontal: 25.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 14.v),
                  _buildSixtyThree(context),
                  SizedBox(height: 48.v),
                  _buildTen(context),
                  _buildTwelve(context),
                  _buildFourteen(context),
                  Spacer(),
                  Divider(),
                  SizedBox(height: 19.v),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFourteen(BuildContext context) {
    return Padding(
      //margin: EdgeInsets.only(left: 25.h, right: 33.h),
      padding: EdgeInsets.only(left: 25.h, right: 33.h),
      child: CustomElevatedButton(
        height: 48.v,
        width: double.infinity,
        text: "About Us",
        margin: EdgeInsets.only(bottom: 16.v),
        leftIcon: CustomImageView(
          imagePath: ImageConstant.aboutUs,
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

  /// Section Widget
  Widget _buildSixtyThree(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 5.h, right: 10.h),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                  imagePath: ImageConstant.imgEllipse6,
                  height: 80.adaptSize,
                  width: 80.adaptSize,
                  radius: BorderRadius.circular(45.h),
                  margin: EdgeInsets.only(top: 8.v)),
              Padding(
                  padding: EdgeInsets.only(top: 35.v, bottom: 34.v),
                  child: Text("Username",
                      style: CustomTextStyles.headlineSmallSemiBold)),
              CustomImageView(
                  imagePath: ImageConstant.imgMobile,
                  height: 37.adaptSize,
                  width: 37.adaptSize,
                  margin: EdgeInsets.only(bottom: 62.v))
            ]));
  }

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

  onTapImgBookmark(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.saveditemsScreen);
  }

  /// Navigates to the loginPageScreen when the action is triggered.
  onTapSignOut(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginPageScreen);
  }

  onTapImgHome(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homepageScreen);
  }
}
