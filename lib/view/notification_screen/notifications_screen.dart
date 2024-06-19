import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qarenly/common/widgets/app_bar/app_bar.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';
import 'package:qarenly/controller/notification_controller.dart';
import 'package:get/get.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  SearchController _searchController = Get.put(SearchController());
  AuthenticationRepo _authenticationRepository = Get.put(AuthenticationRepo());
  NotificationController _notificationController =
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
                print(_notificationController.notifications.value);
                return const Center(
                  child: Text("No Notifications"),
                );
              } else {
                return Expanded(
                    child: NotificationListener(
                  onNotification: (notification) {
                    return true;
                  },
                  child: ListView.builder(
                    itemCount:
                        min(_notificationController.notifications.length, 10),
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text(_notificationController
                              .notifications[index]["title"]!),
                          subtitle: Text(_notificationController
                              .notifications[index]["body"]!));
                    },
                  ),
                ));
              }
            })));
  }
}
