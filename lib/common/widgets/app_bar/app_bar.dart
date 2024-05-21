import 'package:flutter/material.dart';
import 'package:qarenly/common/widgets/app_bar/app_bar_widgets/appbar_menu.dart';
import 'package:qarenly/common/widgets/app_bar/app_bar_widgets/appbar_searchBar.dart';
import 'package:qarenly/common/widgets/app_bar/app_bar_widgets/custom_app_bar.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';
import 'app_bar_widgets/appbar_title_image.dart';
import 'package:get/get.dart';

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController;
  AuthenticationRepo _authenticationRepo = Get.put(AuthenticationRepo());

  BuildAppBar({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 69.h,
      leading: Row(
        children: [
          !_authenticationRepo.currentUser!.isAnonymous
              ? AppbarTitleImage(
                  imagePath: ImageConstant.imgEiUser,
                  margin: EdgeInsets.only(left: 16.h, top: 7.v, bottom: 1.v),
                  onTap: () {
                    onTapBasilProfile(context);
                  },
                )
              : AppbarTitleImage(
                  height: 45,
                  width: 45,
                  imagePath: ImageConstant.Guest_img,
                  margin: EdgeInsets.only(left: 16.h, top: 7.v, bottom: 1.v),
                  onTap: null,
                ),
        ],
      ),
      centerTitle: false,
      title: Container(
        margin: EdgeInsets.only(left: 5.h, top: 10.v, bottom: 1.v),
        child: Expanded(
          child: AppbarSearchBar(
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

void onTapBasilProfile(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.profilePage);
}
