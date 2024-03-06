import 'package:flutter/material.dart';
import 'package:qarenly/common/widgets/custom_elevated_button.dart';
import 'package:qarenly/core/app_export.dart';

class SideMenuScreen extends StatefulWidget {
  SideMenuScreen({Key? key}) : super(key: key);

  @override
  State<SideMenuScreen> createState() => _SideMenuScreenState();
}

class _SideMenuScreenState extends State<SideMenuScreen> {
  //late TextEditingController homeController
  TextEditingController homeController = TextEditingController();

  TextEditingController notificationsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    homeController = TextEditingController();
    notificationsController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Side Menu (Drawer)
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            child: Drawer(
              backgroundColor: appTheme.blueGray300,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                          ),
                          onPressed: () {
                            Navigator.pop(context); // Close the drawer
                          },
                        ),
                        SizedBox(height: 10.v), // Add vertical space
                        _buildSixtyThree(context),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.v),
                  Card(
                    margin: EdgeInsets.only(
                      left: 18,
                      right: 22,
                    ),
                    // Adjust margin as needed
                    elevation: 5.0,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      // Set the border radius
                    ),
                    child: SizedBox(
                      height: 48,
                      child: ListTile(
                        title: Text(
                          'Home',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 6, 51, 89),
                            fontSize: 23,
                          ),
                        ),
                        leading: CustomImageView(
                          imagePath: ImageConstant.imgHome,
                          height: 34.v,
                          width: 30.h,
                        ),
                        onTap: () {
                          onTapImgHome(context);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16.v),
                  Card(
                      margin: EdgeInsets.only(left: 18, right: 22),
                      elevation: 5.0,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            50.0), // Set the border radius
                      ),
                      child: SizedBox(
                          height: 48,
                          child: ListTile(
                            title: Text(
                              'Saved',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 6, 51, 89),
                                fontSize: 23,
                              ),
                            ),
                            leading: CustomImageView(
                              imagePath: ImageConstant.imgBookmark,
                              height: 27.adaptSize,
                              width: 19.adaptSize,
                            ),
                            onTap: () {
                              onTapImgBookmark(context);
                            },
                          ))),
                  SizedBox(height: 16.v),
                  Card(
                      margin: EdgeInsets.only(left: 18, right: 22),
                      elevation: 5.0,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            50.0), // Set the border radius
                      ),
                      child: SizedBox(
                        height: 48,
                        child: ListTile(
                          title: Text(
                            'Notifications',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 6, 51, 89),
                              fontSize: 23,
                            ),
                          ),
                          leading: CustomImageView(
                            imagePath: ImageConstant.imgNotificationiconpng91,
                            height: 32.adaptSize,
                            width: 27.adaptSize,
                          ),
                          onTap: () {},
                        ),
                      )),
                  SizedBox(height: 16.v),
                  Card(
                      margin: EdgeInsets.only(left: 18, right: 22),
                      elevation: 5.0,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            50.0), // Set the border radius
                      ),
                      child: SizedBox(
                        height: 48,
                        child: ListTile(
                          title: Text(
                            'Settings',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 6, 51, 89),
                              fontSize: 23,
                            ),
                          ),
                          leading: CustomImageView(
                            imagePath: ImageConstant.imgSolarSettingsLinear,
                            height: 28.adaptSize,
                            width: 28.adaptSize,
                          ),
                          onTap: () {
                            // Handle Settings onTap
                          },
                        ),
                      )),
                  SizedBox(height: 16.v),
                  Card(
                      margin: EdgeInsets.only(left: 18, right: 22),
                      elevation: 5.0,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            50.0), // Set the border radius
                      ),
                      child: SizedBox(
                        height: 48,
                        child: ListTile(
                          title: Text(
                            'About Us',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 6, 51, 89),
                              fontSize: 23,
                            ),
                          ),
                          leading: CustomImageView(
                            imagePath: ImageConstant.aboutUs,
                            height: 27.adaptSize,
                            width: 27.adaptSize,
                          ),
                          onTap: () {
                            // Handle About Us onTap
                          },
                        ),
                      )),
                  SizedBox(height: 16.v),
                  Spacer(),
                  Divider(),
                  SizedBox(height: 190.v),
                  Card(
                      margin: EdgeInsets.only(left: 18, right: 70),
                      elevation: 5.0,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            50.0), // Set the border radius
                      ),
                      child: SizedBox(
                        height: 50,
                        child: ListTile(
                          title: Text(
                            'Dark mode',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 6, 51, 89),
                              fontSize: 23,
                            ),
                          ),
                          leading: CustomImageView(
                            imagePath: ImageConstant.nightmode,
                            height: 40.adaptSize,
                            width: 40.adaptSize,
                          ),
                          onTap: () {},
                        ),
                      )),
                  SizedBox(height: 16.v),
                  Card(
                    margin: EdgeInsets.only(left: 18, right: 70),
                    elevation: 5.0,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(50.0), // Set the border radius
                    ),
                    child: SizedBox(
                      height: 50,
                      child: ListTile(
                        title: Text(
                          'Sign Out',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 6, 51, 89),
                            fontSize: 23,
                          ),
                        ),
                        leading: CustomImageView(
                          imagePath: ImageConstant.imgUilsignoutalt,
                          height: 33.adaptSize,
                          width: 33.adaptSize,
                        ),
                        onTap: () {
                          onTapSignOut(context);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Other methods (_buildSixtyThree, _buildFourteen, etc.) remain unchanged
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
  return Row(
    children: [
      CustomImageView(
        imagePath: ImageConstant.imgEllipse6,
        height: 70.adaptSize,
        width: 70.adaptSize,
        radius: BorderRadius.circular(40.h),
        margin: EdgeInsets.only(
            right: 20.h), // Increase the right margin for spacing
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Username",
            style: CustomTextStyles.headlineSmallSemiBold,
          ),
          // Add some vertical space between the username and the bottom edge of the header
          CustomImageView(
            imagePath: ImageConstant.imgMobile,
            height: 15.adaptSize,
            width: 15.adaptSize,
          ),
        ],
      ),
    ],
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
