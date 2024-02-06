import '../saveditems_screen/widgets/productcard_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/widgets/app_bar/appbar_leading_image.dart';
import 'package:qarenly/widgets/app_bar/appbar_title_image.dart';
import 'package:qarenly/widgets/app_bar/appbar_trailing_image.dart';
import 'package:qarenly/widgets/app_bar/custom_app_bar.dart';

class SaveditemsScreen extends StatelessWidget {
  const SaveditemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor:
                theme.colorScheme.onSecondaryContainer.withOpacity(0.99),
            appBar: _buildAppBar(context),
            body: Padding(
                padding: EdgeInsets.only(left: 17.h, top: 48.v, right: 17.h),
                child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 1.v);
                    },
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ProductcardItemWidget();
                    }))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 63.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgEiUser,
            margin: EdgeInsets.only(left: 10.h, top: 1.v, bottom: 1.v)),
        centerTitle: true,
        title: AppbarTitleImage(imagePath: ImageConstant.imgGroup51),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgBasilMenuOutline,
              margin: EdgeInsets.fromLTRB(6.h, 3.v, 20.h, 4.v),
              onTap: () {
                onTapBasilMenuOutline(context);
              })
        ]);
  }

  /// Navigates to the sideMenuScreen when the action is triggered.
  onTapBasilMenuOutline(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.sideMenuScreen);
  }
}
