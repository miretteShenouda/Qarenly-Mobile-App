import '../../widgets/app_bar/appbar_title_searchview.dart';
import '../../widgets/custom_text_form_field.dart';
import '../saveditems_screen/widgets/productcard_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/widgets/app_bar/appbar_leading_image.dart';
import 'package:qarenly/widgets/app_bar/appbar_title_image.dart';
import 'package:qarenly/widgets/app_bar/appbar_trailing_image.dart';
import 'package:qarenly/widgets/app_bar/custom_app_bar.dart';

class SaveditemsScreen extends StatelessWidget {
  SaveditemsScreen({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: theme.colorScheme.onSecondaryContainer.withOpacity(0.99),
      appBar: _buildAppBar(context),
      //    body:
      // Padding(
      // padding: EdgeInsets.only(left: 17.h, top: 48.v, right: 17.h),
      // child: ListView.separated(
      //     physics: AlwaysScrollableScrollPhysics(),
      //     //NeverScrollableScrollPhysics(),
      //     shrinkWrap: true,
      //     separatorBuilder: (context, index) {
      //       return SizedBox(height: 1.v);
      //     },
      //     itemCount: 5,
      //     itemBuilder: (context, index) {
      //       return ProductcardItemWidget();
      //     })
      //  )
    ));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize:
          Size.fromHeight(kToolbarHeight + 40), // Adjust the height as needed
      child: Column(
        children: [
          CustomAppBar(
            leadingWidth: 69.h,
            leading: Row(
              children: [
                AppbarLeadingImage(
                  imagePath: ImageConstant.imgEiUser,
                  margin: EdgeInsets.only(left: 16.h, top: 1.v, bottom: 1.v),
                ),
              ],
            ),
            centerTitle: true,
            title: Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 15.h, top: 10.v, bottom: 1.v),
                child: AppbarTitleSearchview(
                  hintText: "search",
                  controller: searchController,
                ),
              ),
            ),
            actions: [
              AppbarTrailingImage(
                imagePath: ImageConstant.imgBasilMenuOutline,
                margin: EdgeInsets.fromLTRB(7.h, 8.v, 15.h, 1.v),
                onTap: () {
                  onTapBasilMenuOutline(context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  /// Navigates to the sideMenuScreen when the action is triggered.
  onTapBasilMenuOutline(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.sideMenuScreen);
  }

  Widget _buildSearchBar(BuildContext context) {
    return CustomTextFormField(
      controller: searchController,
      hintText: "search",
      textInputAction: TextInputAction.done,
      //textInputType: TextInputType.visiblePassword,
      prefix: Padding(
        padding: EdgeInsets.fromLTRB(10.h, 5.v, 4.h, 5.v),
      ),
      prefixConstraints: BoxConstraints(maxHeight: 40.v),
      obscureText: true,
      contentPadding: EdgeInsets.symmetric(vertical: 10.v, horizontal: 10.h),
    );
  }
}
