import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';
import 'core/app_export.dart';
import 'firebase_options.dart';


Future<void> NotificationHandlerBackground(RemoteMessage message) async {
  try {
    print(message.data.toString());
  } catch (e) {
    print(e.toString());
  }
}

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() async {
  //trails to solve the exception of parentwidget
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );

  // FirebaseMessaging.onMessage.listen();
  FirebaseMessaging.onBackgroundMessage(NotificationHandlerBackground);

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          theme: theme,
          title: 'qarenly',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splashScreen,
          // AppRoutes.signUpPageScreen,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
