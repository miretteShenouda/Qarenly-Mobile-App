import 'package:flutter/material.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/common/widgets/app_bar/appbar_leading_image.dart';
import 'package:qarenly/common/widgets/app_bar/appbar_title_searchview.dart';
import 'package:qarenly/common/widgets/app_bar/appbar_trailing_image.dart';
import 'package:qarenly/common/widgets/app_bar/custom_app_bar.dart';

import '../homepage_screen/widgets/userprofile_item_widget.dart';

// ignore_for_file: must_be_immutable
class HomepageScreen extends StatelessWidget {
  HomepageScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          width: 391.h,
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 24.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.v),

              // Section 1: Horizontal Scrolling
              _buildHorizontalScrollingSection(),
              SizedBox(height: 8.v), // Adjust spacing as needed
              Padding(
                padding: EdgeInsets.only(left: 13.h),
              ),
              SizedBox(height: 18.v),
              // Section 2: Recent Deals
              _buildRecentDealsSection(context),
              SizedBox(height: 34.v),
              Padding(
                padding: EdgeInsets.only(left: 8.h),
              ),
              // Padding(
              //   padding: EdgeInsets.only(left: 8.h),
              // ), // Adjust spacing as needed

              // Section 3: Mostly Viewed
              _buildMostlyViewedSection(),
            ],
          ),
        ),
      ),
    ));
  }

  /// Section Widget...search bar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 69.h,
      leading: Row(
        children: [
          AppbarLeadingImage(
            imagePath: ImageConstant.imgEiUser,
            margin: EdgeInsets.only(left: 16.h, top: 7.v, bottom: 1.v),
          ),
        ],
      ),
      centerTitle: false, // Change to false to allow the title to expand
      title: Container(
        // Wrap the title in a container to apply margin
        margin: EdgeInsets.only(left: 5.h, top: 10.v, bottom: 1.v),
        child: Expanded(
          // Wrap the container in Expanded to make it flexible
          child: AppbarTitleSearchview(
            hintText: "search",
            controller: searchController,
          ),
        ),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgBasilMenuOutline,
          margin: EdgeInsets.fromLTRB(6.h, 8.v, 15.h, 1.v),
          onTap: () {
            onTapBasilMenuOutline(context);
          },
        ),
      ],
    );
  }

  // Widget for Section 1: Horizontal Scrolling
  Widget _buildHorizontalScrollingSection() {
    // Implement your horizontal scrolling widget here
    return Container(
      decoration: AppDecoration.fillPrimary,
      height: 198, // Set the height as per your requirement
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3, // Example itemCount
        itemBuilder: (context, index) {
          return Container(
              decoration: AppDecoration.fillPrimary,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 2.v),
                    CustomImageView(
                        imagePath: ImageConstant.imgSmartGadgetV3,
                        height: 211.v,
                        width: 351.h)
                  ]));
        },
      ),
    );
  }

  // Widget for Section 2: Recent Deals
  Widget _buildRecentDealsSection(BuildContext context) {
    // Implement your recent deals widget here

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Deals',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10), // Adjust spacing as needed
        ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(height: 21.v);
            },
            itemCount: 2,
            itemBuilder: (context, index) {
              return UserprofileItemWidget();
            }),
      ],
    );
  }

  // Widget for Section 3: Mostly Viewed
  Widget _buildMostlyViewedSection() {
    // Implement your mostly viewed widget here
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mostly Viewed',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10), // Adjust spacing as needed
        ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(height: 21.v);
            },
            itemCount: 5,
            itemBuilder: (context, index) {
              return UserprofileItemWidget();
            }),
      ],
    );
  }

  // /// Section Widget....Mostly viewed
  // Widget _buildNinety(BuildContext context) {
  //   return Container(
  //       height: 123.v,
  //       width: 350.h,
  //       margin: EdgeInsets.only(left: 25.h, right: 16.h),
  //       child: Stack(alignment: Alignment.centerLeft, children: [
  //         Align(
  //             alignment: Alignment.center,
  //             child: Container(
  //                 height: 123.v,
  //                 width: 350.h,
  //                 decoration: BoxDecoration(
  //                     color: theme.colorScheme.onPrimaryContainer
  //                         .withOpacity(0.24),
  //                     borderRadius: BorderRadius.circular(20.h)))),
  //         Align(
  //             alignment: Alignment.centerLeft,
  //             child: Row(children: [
  //               CustomImageView(
  //                   imagePath: ImageConstant.img164691852916392,
  //                   height: 123.v,
  //                   width: 105.h,
  //                   radius: BorderRadius.circular(20.h)),
  //               Padding(
  //                   padding: EdgeInsets.only(left: 6.h, top: 23.v, bottom: 8.v),
  //                   child: Column(mainAxisSize: MainAxisSize.min, children: [
  //                     SizedBox(
  //                         width: 209.h,
  //                         child: Text(
  //                             "ASUS Laptop Zenbook Pro 14\nSource: sigma\n\n ",
  //                             maxLines: 2,
  //                             overflow: TextOverflow.ellipsis,
  //                             style: theme.textTheme.bodyMedium)),
  //                     Align(
  //                         alignment: Alignment.centerRight,
  //                         child: Padding(
  //                             padding: EdgeInsets.only(top: 32.v),
  //                             child: RichText(
  //                                 text: TextSpan(children: [
  //                                   TextSpan(
  //                                       text: "30,400",
  //                                       style: CustomTextStyles
  //                                           .titleSmallff000000
  //                                           .copyWith(
  //                                               decoration: TextDecoration
  //                                                   .lineThrough)),
  //                                   TextSpan(
  //                                       text: " LE 20,999",
  //                                       style:
  //                                           CustomTextStyles.titleSmallff000000)
  //                                 ]),
  //                                 textAlign: TextAlign.left)))
  //                   ]))
  //             ]))
  //       ]));
  // }

  /// Navigates to the sideMenuScreen when the action is triggered.
  onTapBasilMenuOutline(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.sideMenuScreen);
  }
}
