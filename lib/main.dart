import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/app_export.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme,
          title: 'qarenly',
          debugShowCheckedModeBanner: false,
          initialRoute:
              //AppRoutes.saveditemsScreen,
              // AppRoutes.searchOutputPage,
              AppRoutes.viewproductPage,
          //AppRoutes.homepageScreen,

          ///AppRoutes.splashscreenScreen,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
