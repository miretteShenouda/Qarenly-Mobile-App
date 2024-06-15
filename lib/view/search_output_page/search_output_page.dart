import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qarenly/core/app_export.dart';

import '../../common/widgets/ProductcardItemWidgetHome.dart';
import '../../controller/homePage_controller.dart';

// ignore_for_file: must_be_immutable
class SearchOutputPage extends StatefulWidget {
  const SearchOutputPage({Key? key})
      : super(
          key: key,
        );

  @override
  SearchOutputPageState createState() => SearchOutputPageState();
}

class SearchOutputPageState extends State<SearchOutputPage>
    with AutomaticKeepAliveClientMixin<SearchOutputPage> {
  final controller = Get.put(HomePageController());

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillOnSecondaryContainer1,
          child: Column(
            children: [
              SizedBox(height: 29.v),
              _buildUserProfileSection(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildUserProfileSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 19.h),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (
          context,
          index,
        ) {
          return SizedBox(
            height: 22.v,
          );
        },
        itemCount: 4,
        itemBuilder: (context, index) {
          return ProductcardItemWidgetHome(
            product: controller.products[index],
            // homePageController: controller,
          );
        },
      ),
    );
  }
}
