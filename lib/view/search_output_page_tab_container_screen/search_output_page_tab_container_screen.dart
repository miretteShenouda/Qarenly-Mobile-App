import 'package:flutter/material.dart';
// import 'package:qarenly/common/widgets/app_bar/appbar_title_searchview.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';
import 'package:qarenly/view/search_output_page/search_output_page.dart';

import 'package:get/get.dart';
import '../../common/widgets/app_bar/app_bar.dart';
// import 'package:qarenly/common/widgets/app_bar/appbar_leading_image.dart';
// import 'package:qarenly/common/widgets/app_bar/appbar_trailing_image.dart';
// import 'package:qarenly/common/widgets/app_bar/custom_app_bar.dart';

class SearchOutputPageTabContainerScreen extends StatefulWidget {
  const SearchOutputPageTabContainerScreen({Key? key}) : super(key: key);

  @override
  SearchOutputPageTabContainerScreenState createState() =>
      SearchOutputPageTabContainerScreenState();
}

// ignore_for_file: must_be_immutable
class SearchOutputPageTabContainerScreenState
    extends State<SearchOutputPageTabContainerScreen>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  final _authenticationRepo = Get.put(AuthenticationRepo());

  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: BuildAppBar(searchController: searchController , authenticationRepo: _authenticationRepo,),
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  SizedBox(height: 10.v),
                  _buildTabview(context),
                  SizedBox(
                      height: 706.v,
                      child: TabBarView(
                          controller: tabviewController,
                          children: [
                            SearchOutputPage(),
                            SearchOutputPage(),
                            SearchOutputPage()
                          ]))
                ]))));
  }

  // /// Section Widget
  // PreferredSizeWidget _buildAppBar(BuildContext context) {
  //   return CustomAppBar(
  //       leadingWidth: 67.h,
  //       leading: AppbarLeadingImage(
  //           imagePath: ImageConstant.imgEiUser,
  //           margin: EdgeInsets.only(left: 14.h, top: 1.v, bottom: 1.v)),
  //       centerTitle: true,
  //       title: AppbarTitleSearchview(
  //           hintText: "search", controller: searchController),
  //       actions: [
  //         AppbarTrailingImage(
  //             imagePath: ImageConstant.imgBasilMenuOutline,
  //             margin: EdgeInsets.fromLTRB(6.h, 3.v, 16.h, 4.v),
  //             onTap: () {
  //               onTapBasilMenuOutline(context);
  //             })
  //       ]);
  // }

  /// Section Widget
  Widget _buildTabview(BuildContext context) {
    return Container(
        height: 37.v,
        width: 343.h,
        child: TabBar(
            controller: tabviewController,
            labelPadding: EdgeInsets.zero,
            tabs: [
              Tab(child: Text("brand")),
              Tab(child: Text("new arrivals")),
              Tab(child: Text("price"))
            ]));
  }

  /// Navigates to the sideMenuScreen when the action is triggered.
  onTapBasilMenuOutline(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.sideMenuScreen);
  }
}
