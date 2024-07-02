import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qarenly/common/widgets/app_bar/app_bar.dart';
import 'package:qarenly/controller/notification_controller.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';
import 'package:qarenly/routes/app_routes.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final SearchController _searchController = Get.put(SearchController());
  final AuthenticationRepo _authenticationRepository =
      Get.put(AuthenticationRepo());
  final NotificationController _notificationController =
      Get.put(NotificationController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _notificationController.getNotifications();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BuildAppBar(
          searchController: _searchController,
          authenticationRepo: _authenticationRepository,
        ),
        body: Obx(() {
          if (_notificationController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (_notificationController.notifications.isEmpty) {
            return const Center(
              child: Text("No Notifications"),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: min(_notificationController.notifications.length, 10),
              itemBuilder: (context, index) {
                final notification =
                    _notificationController.notifications[index];
                return GestureDetector(
                  onTap: notification["id"] != null
                      ? () {
                          Navigator.pushNamed(
                              context, AppRoutes.viewproductPage,
                              arguments: {
                                'productId': notification["id"],
                                'productType': notification["type"],
                              });
                        }
                      : null,
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                    child: ListTile(
                      leading: Icon(Icons.notifications,
                          color: Color.fromRGBO(0, 48, 73, 1)),
                      title: Text(
                        notification["title"]!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 48, 73, 1)),
                      ),
                      subtitle: Text(
                        notification["body"]!,
                        style: TextStyle(
                            color: Color.fromRGBO(0, 48, 73, 0.6),
                            fontStyle: FontStyle.normal),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
