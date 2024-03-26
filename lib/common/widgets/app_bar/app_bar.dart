import 'package:flutter/material.dart';
import 'package:qarenly/common/widgets/app_bar/app_bar_widgets/appbar_menu.dart';
import 'package:qarenly/common/widgets/app_bar/app_bar_widgets/appbar_searchBar.dart';
import 'package:qarenly/common/widgets/app_bar/app_bar_widgets/custom_app_bar.dart';
import 'package:qarenly/core/app_export.dart';

import 'app_bar_widgets/appbar_title_image.dart';

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController;
  const BuildAppBar({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 69.h,
      leading: Row(
        children: [
          AppbarTitleImage(
            imagePath: ImageConstant.imgEiUser,
            margin: EdgeInsets.only(left: 16.h, top: 7.v, bottom: 1.v),
          ),
        ],
      ),
      centerTitle: false,
      title: Container(
        margin: EdgeInsets.only(left: 5.h, top: 10.v, bottom: 1.v),
        child: Expanded(
          child: AppbarSearchBar(
            // hintText: "search",
            controller: searchController,
          ),
        ),
      ),
      actions: [
        AppbarMenu(
          imagePath: ImageConstant.imgBasilMenuOutline,
          margin: EdgeInsets.fromLTRB(6.h, 8.v, 15.h, 1.v),
          onTap: () {
            onTapBasilMenuOutline(context);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

void onTapBasilMenuOutline(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.sideMenuScreen);
}
