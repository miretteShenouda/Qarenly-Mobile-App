import 'package:flutter/material.dart';
import 'package:qarenly/view/homepage_screen/homepage_screen.dart';
import 'package:qarenly/view/login_page_screen/login_page_screen.dart';
import 'package:qarenly/view/saveditems_screen/saveditems_screen.dart';
import 'package:qarenly/view/search_output_page/search_output_page.dart';
import 'package:qarenly/view/search_output_page_tab_container_screen/search_output_page_tab_container_screen.dart';
import 'package:qarenly/view/side_menu_screen/side_menu_screen.dart';
import 'package:qarenly/view/sign_up_page_screen/sign_up_page_screen.dart';
import 'package:qarenly/view/splashscreen_screen/splashscreen_screen.dart';
import 'package:qarenly/view/viewproduct_page/viewproduct_page.dart';
import 'package:qarenly/view/profile_update_screen/update_profile.dart';

// import 'package:qarenly/presentation/forget_password_screen/forget_password_mail/mail_screen.dart';

class AppRoutes {
  static const String saveditemsScreen = '/saveditems_screen';

  static const String splashscreenScreen = '/splashscreen_screen';

  static const String loginPageScreen = '/login_page_screen';

  static const String signUpPageScreen = '/sign_up_page_screen';

  static const String homepageScreen = '/homepage_screen';

  static const String searchOutputPage = '/search_output_page';

  static const String searchOutputPageTabContainerScreen =
      '/search_output_page_tab_container_screen';

  static const String viewproductPage = '/viewproduct_page';

  static const String sideMenuScreen = '/side_menu_screen';

  static const String profilePage = '/profile_update_screen';

  // static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    saveditemsScreen: (context) => SaveditemsScreen(),
    splashscreenScreen: (context) => SplashscreenScreen(),
    loginPageScreen: (context) => LoginPageScreen(),
    signUpPageScreen: (context) => SignUpPageScreen(),
    homepageScreen: (context) => HomepageScreen(),
    searchOutputPageTabContainerScreen: (context) =>
        SearchOutputPageTabContainerScreen(),
    searchOutputPage: (context) => SearchOutputPage(),
    sideMenuScreen: (context) => SideMenuScreen(),
    viewproductPage: (context) => ViewproductPage(),
    profilePage: (context) => UpdateProfileScreen(),
  };
}
