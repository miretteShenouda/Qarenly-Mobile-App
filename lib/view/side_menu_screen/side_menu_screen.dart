import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qarenly/common/widgets/custom_elevated_button.dart';
import 'package:qarenly/controller/filter_controller.dart';
import 'package:qarenly/controller/homePage_controller.dart';
import 'package:qarenly/controller/notification_controller.dart';
import 'package:qarenly/controller/profile_controller.dart';
import 'package:qarenly/controller/savedItems_controller.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';
import 'package:qarenly/view/login_page_screen/login_page_screen.dart';

class SideMenuScreen extends StatefulWidget {
  SideMenuScreen({Key? key}) : super(key: key);

  @override
  State<SideMenuScreen> createState() => _SideMenuScreenState();
}

class _SideMenuScreenState extends State<SideMenuScreen> {
  //late TextEditingController homeController
  TextEditingController homeController = TextEditingController();

  TextEditingController notificationsController = TextEditingController();

  AuthenticationRepo _authenticationRepo = Get.put(AuthenticationRepo());

  bool isDark = false;
  @override
  void initState() {
    super.initState();
    homeController = TextEditingController();
    notificationsController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Theme(
      // data: isDark ? ThemeData.dark() : ThemeData.light(),
      // child: Scaffold(
      body: Stack(
        children: [
          // Transparent overlay
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: MediaQuery.of(context).size.width * 0.8,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(
                    context); // Close the drawer when tapping on the transparent area
              },
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          // Side Menu (Drawer)
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width *
                  0.8, // Adjust width as needed
              child: Drawer(
                // backgroundColor: appTheme.blueGray300,
                backgroundColor: isDark ? Colors.black : appTheme.blueGray300,
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
                              fontSize: 20,
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
                    !_authenticationRepo.currentUser!.isAnonymous
                        ? Card(
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
                                      color:
                                          const Color.fromARGB(255, 6, 51, 89),
                                      fontSize: 20,
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
                                )))
                        : Card(
                            margin: EdgeInsets.only(left: 18, right: 22),
                            elevation: 5.0,
                            color: Colors.grey[500],
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
                                      color:
                                          const Color.fromARGB(255, 6, 51, 89),
                                      fontSize: 20,
                                    ),
                                  ),
                                  leading: CustomImageView(
                                    imagePath: ImageConstant.imgBookmark,
                                    height: 27.adaptSize,
                                    width: 19.adaptSize,
                                  ),
                                  trailing: Icon(Icons.lock),
                                ))),
                    SizedBox(height: 16.v),
                    !_authenticationRepo.currentUser!.isAnonymous
                        ? Card(
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
                                    fontSize: 20,
                                  ),
                                ),
                                leading: CustomImageView(
                                  imagePath:
                                      ImageConstant.imgNotificationiconpng91,
                                  height: 32.adaptSize,
                                  width: 27.adaptSize,
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.notificationsPage);
                                },
                              ),
                            ))
                        : Card(
                            margin: EdgeInsets.only(left: 18, right: 22),
                            elevation: 5.0,
                            color: Colors.grey[500],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  50.0), // Set the border radius
                            ),
                            child: SizedBox(
                                height: 48,
                                child: ListTile(
                                  title: Text(
                                    'Notification',
                                    style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 6, 51, 89),
                                      fontSize: 20,
                                    ),
                                  ),
                                  leading: CustomImageView(
                                    imagePath: ImageConstant.imgBookmark,
                                    height: 27.adaptSize,
                                    width: 19.adaptSize,
                                  ),
                                  trailing: Icon(Icons.lock),
                                ))),
                    SizedBox(height: 16.v),
                    // Card(
                    //     margin: EdgeInsets.only(left: 18, right: 22),
                    //     elevation: 5.0,
                    //     color: Color.fromRGBO(255, 255, 255, 1),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(
                    //           50.0), // Set the border radius
                    //     ),
                    //     child: SizedBox(
                    //       height: 48,
                    //       child: ListTile(
                    //         title: Text(
                    //           'Settings',
                    //           style: TextStyle(
                    //             color: const Color.fromARGB(255, 6, 51, 89),
                    //             fontSize: 23,
                    //           ),
                    //         ),
                    //         leading: CustomImageView(
                    //           imagePath: ImageConstant.imgSolarSettingsLinear,
                    //           height: 28.adaptSize,
                    //           width: 28.adaptSize,
                    //         ),
                    //       ),
                    //     )),
                    // SizedBox(height: 16.v),
                    // Card(
                    //     margin: EdgeInsets.only(left: 18, right: 22),
                    //     elevation: 5.0,
                    //     color: Color.fromRGBO(255, 255, 255, 1),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(
                    //           50.0), // Set the border radius
                    //     ),
                    //     child: SizedBox(
                    //       height: 48,
                    //       child: ListTile(
                    //         title: Text(
                    //           'About Us',
                    //           style: TextStyle(
                    //             color: const Color.fromARGB(255, 6, 51, 89),
                    //             fontSize: 23,
                    //           ),
                    //         ),
                    //         leading: CustomImageView(
                    //           imagePath: ImageConstant.aboutUs,
                    //           height: 27.adaptSize,
                    //           width: 27.adaptSize,
                    //         ),
                    //         onTap: () {
                    //           // Handle About Us onTap
                    //         },
                    //       ),
                    //     )),
                    // SizedBox(height: 16.v),
                    Spacer(),
                    Divider(),
                    SizedBox(height: 335.v),
                    // Card(
                    //     margin: EdgeInsets.only(left: 18, right: 70),
                    //     elevation: 5.0,
                    //     color: Color.fromRGBO(255, 255, 255, 1),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(
                    //           50.0), // Set the border radius
                    //     ),
                    // child: SizedBox(
                    //   height: 50,
                    //   child: ListTile(
                    //     title: Text(
                    //       'Dark mode',
                    //       style: TextStyle(
                    //         color: const Color.fromARGB(255, 6, 51, 89),
                    //         fontSize: 23,
                    //       ),
                    //     ),
                    //     leading: CustomImageView(
                    //       imagePath: ImageConstant.nightmode,
                    //       height: 40.adaptSize,
                    //       width: 40.adaptSize,
                    //     ),
                    //     onTap: () {
                    //       darkMode();
                    //     },
                    //   ),
                    // )),
                    SizedBox(height: 16.v),
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
                            'Sign Out',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 6, 51, 89),
                              fontSize: 20,
                            ),
                          ),
                          leading: CustomImageView(
                            imagePath: ImageConstant.imgUilsignoutalt,
                            height: 33.adaptSize,
                            width: 33.adaptSize,
                          ),
                          onTap: () async {
                            // onTapSignOut(context);
                            await _authenticationRepo.logout();
                            await _authenticationRepo.signOutFromGoogle();
                            await _authenticationRepo.signOutFacebook(context);

                            Get.delete<SavedItemsController>();
                            Get.delete<NotificationController>();
                            Get.delete<FilterController>();
                            Get.delete<HomePageController>();
                            Get.delete<ProfileController>();

                            Get.offAll(() => LoginPageScreen());
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void darkMode() {
    setState(() {
      isDark = !isDark;
    });
  }
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
      Text("Hi, ${AuthenticationRepo.instance.userData!.username}",
          style: CustomTextStyles.headlineSmallSemiBold),
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
// onTapSignOut(BuildContext context) {

//   Navigator.pushNamed(context, AppRoutes.loginPageScreen);
// }

onTapImgHome(BuildContext context) {
  Navigator.pushReplacementNamed(context, AppRoutes.homepageScreen);
}
