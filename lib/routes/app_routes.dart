import 'package:flutter/material.dart';
import 'package:qarenly/presentation/homepage_screen/homepage_screen.dart';
import 'package:qarenly/presentation/login_page_screen/login_page_screen.dart';
import 'package:qarenly/presentation/saveditems_screen/saveditems_screen.dart';
import 'package:qarenly/presentation/search_output_page/search_output_page.dart';
import 'package:qarenly/presentation/search_output_page_tab_container_screen/search_output_page_tab_container_screen.dart';
import 'package:qarenly/presentation/side_menu_screen/side_menu_screen.dart';
import 'package:qarenly/presentation/sign_up_page_screen/sign_up_page_screen.dart';
import 'package:qarenly/presentation/splashscreen_screen/splashscreen_screen.dart';
import 'package:qarenly/presentation/viewproduct_page/viewproduct_page.dart';
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

  static const String appNavigationScreen = '/app_navigation_screen';

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
  };
}
