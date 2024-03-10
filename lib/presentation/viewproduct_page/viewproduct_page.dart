import 'package:flutter/material.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/presentation/viewproduct_page/widgets/app_bar/appbar_leading_image.dart';
import 'package:qarenly/presentation/viewproduct_page/widgets/app_bar/appbar_title_searchview.dart';
import 'package:qarenly/presentation/viewproduct_page/widgets/app_bar/appbar_trailing_image.dart';
import 'package:qarenly/presentation/viewproduct_page/widgets/app_bar/custom_app_bar.dart';
import 'package:qarenly/presentation/viewproduct_page/widgets/custom_icon_button.dart';

// ignore_for_file: must_be_immutable
class ViewproductPage extends StatelessWidget {
  ViewproductPage({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: theme.colorScheme.onError,
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 15.v),
                    child: Padding(
                        padding: EdgeInsets.only(right: 3.h),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildProductNameDell(context),
                              SizedBox(height: 15.v),
                              // CustomImageView(
                              //     imagePath: ImageConstant.img30702,
                              //     height: 231.v,
                              //     width: 213.h,
                              //     radius: BorderRadius.circular(20.h),
                              //     alignment: Alignment.center),
                              SizedBox(height: 25.v),
                              Container(
                                  width: 368.h,
                                  margin:
                                      EdgeInsets.only(left: 16.h, right: 2.h),
                                  child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: "\n",
                                            style: theme.textTheme.titleLarge),
                                        TextSpan(
                                            text: "\n\n\n\n\n\n\n\n",
                                            style: theme.textTheme.titleLarge),
                                        TextSpan(
                                            text: "\n",
                                            style: theme.textTheme.titleLarge),
                                        TextSpan(
                                            text: "\n",
                                            style: theme.textTheme.titleLarge),
                                        TextSpan(
                                            text: "\n",
                                            style: theme.textTheme.titleLarge),
                                        // TextSpan(
                                        //     text: "\nProduct Description:\n",
                                        //     style: CustomTextStyles
                                        //         .titleLargeBold_1),
                                        TextSpan(text: " "),
                                        TextSpan(
                                            text: "13th Generation Intel Core",
                                            style: theme.textTheme.titleLarge),
                                        TextSpan(text: " "),
                                        TextSpan(
                                            text:
                                                "i7-1355U, 14\"16:10 FHD+ Touchscreen, \n16GB RAM, 512GB SSD,\n Backlit Keyboard, Fingerprint \nReader,\nBrand:Dell\nModel name: Inspiron 14 2-in-1\nLaptopScreen size: 14 Inches\nColourPlatinum: Silver\nCPU model: Core i7 Family\nRAM memory installed size: 16 GB \n\n",
                                            style: theme.textTheme.titleLarge),
                                        TextSpan(
                                            text: "\n",
                                            style: theme.textTheme.titleLarge!
                                                .copyWith(
                                                    decoration: TextDecoration
                                                        .underline))
                                      ]),
                                      textAlign: TextAlign.left)),
                              SizedBox(height: 25.v),
                              Padding(
                                padding: EdgeInsets.only(left: 15.h),
                              ),
                              SizedBox(height: 29.v),
                              _buildIcomoonFreeAmazon(context),
                              SizedBox(height: 19.v),
                              _buildPrice(context),
                              SizedBox(height: 39.v),
                              Text("Line chart",
                                  textAlign: TextAlign.center,
                                  style: CustomTextStyles.titleLargeBold),
                              SizedBox(height: 28.v),
                              // CustomImageView(
                              //     imagePath: ImageConstant.imgRectangle5243x376,
                              //     height: 243.v,
                              //     width: 376.h,
                              //     radius: BorderRadius.circular(10.h)),
                              SizedBox(height: 28.v),
                              Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      width: 325.h,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 31.h),
                                      child: Text(
                                          "Regression output: Go for this product\nNoooooooowwwwwww",
                                          maxLines: null,
                                          overflow: TextOverflow.ellipsis,
                                          style: CustomTextStyles
                                              .titleLargeBold))),
                              SizedBox(height: 47.v),
                              Padding(
                                  padding: EdgeInsets.only(left: 3.h),
                                  child: Text("What else to consider",
                                      textAlign: TextAlign.center,
                                      style: CustomTextStyles.titleLargeBold)),
                              SizedBox(height: 16.v),
                              _buildArrowRight(context)
                            ]))))));
  }

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
      centerTitle: false,
      title: Container(
        margin: EdgeInsets.only(left: 5.h, top: 10.v, bottom: 1.v),
        child: Expanded(
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

/*
  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 69.h,
        leading: AppbarLeadingImage(
            // imagePath: ImageConstant.imgEiUserOnprimarycontainer,
            margin: EdgeInsets.only(left: 16.h, top: 1.v, bottom: 1.v)),
        title: AppbarTitleSearchview(
            margin: EdgeInsets.only(top: 6.v, right: 54.h, bottom: 6.v),
            hintText: "Search",
            controller: searchController),
        actions: [
          Container(
              margin: EdgeInsets.only(left: 204.h),
              // decoration: AppDecoration.row8,
              child: Row(children: [
                AppbarTrailingImage(
                    // imagePath: ImageConstant.imgBasilCrossSolid,
                    margin: EdgeInsets.only(top: 1.v)),
                // AppbarTrailingImage(
                //     imagePath:
                //         ImageConstant.imgBasilMenuOutlineOnsecondarycontainer,
                //     margin: EdgeInsets.only(left: 6.h, bottom: 2.v),
                //     onTap: () {
                //       onTapBasilMenuOutline(context);
                //     })
              ]))
        ]);
  }
*/
  /// Section Widget
  Widget _buildProductNameDell(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.h),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 151.h,
                      child: RichText(
                          text: TextSpan(children: [
                            // TextSpan(
                            //     text: "Product Name:",
                            //     style: CustomTextStyles.titleLargeBold_1),
                            TextSpan(
                                text: " \n", style: theme.textTheme.titleLarge),
                            TextSpan(
                                text: "Dell Inspiron 14",
                                style: theme.textTheme.titleLarge)
                          ]),
                          textAlign: TextAlign.left)),
                  Spacer(),
                  Padding(
                      padding: EdgeInsets.only(top: 3.v, bottom: 11.v),
                      child: CustomIconButton(
                        height: 40.adaptSize,
                        width: 40.adaptSize,
                        // child: CustomImageView(
                        //     imagePath:
                        //         ImageConstant.imgContrastBlueGray100)
                      )),
                  Padding(
                      padding:
                          EdgeInsets.only(left: 23.h, top: 3.v, bottom: 11.v),
                      child: CustomIconButton(
                        height: 40.adaptSize,
                        width: 40.adaptSize,
                        // child: CustomImageView(
                        //     imagePath: ImageConstant.imgBookmarkBlueGray100)
                      ))
                ])));
  }

  /// Section Widget
  Widget _buildIcomoonFreeAmazon(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: Padding(
            padding: EdgeInsets.only(left: 31.h),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                  padding: EdgeInsets.only(top: 18.v, bottom: 22.v),
                  child: CustomIconButton(
                    height: 50.adaptSize,
                    width: 50.adaptSize,
                    padding: EdgeInsets.all(3.h),
                    // child: CustomImageView(
                    //     imagePath: ImageConstant
                    //         .imgIcomoonFreeAmazonOnsecondarycontainer)
                  )),
              Container(
                  height: 90.v,
                  width: 259.h,
                  margin: EdgeInsets.only(left: 20.h),
                  child: Stack(alignment: Alignment.bottomCenter, children: [
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                            height: 89.v,
                            width: 259.h,
                            decoration: BoxDecoration(
                                color: theme.colorScheme.onSecondaryContainer
                                    .withOpacity(0.24)))),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                            width: 159.h,
                            child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "669.00",
                                      style: theme.textTheme.bodyLarge!
                                          .copyWith(
                                              decoration:
                                                  TextDecoration.lineThrough)),
                                  TextSpan(
                                      text: " 483.00 \n(27% off)\n",
                                      style: theme.textTheme.bodyLarge)
                                ]),
                                textAlign: TextAlign.center)))
                  ])),
              Container(
                  margin: EdgeInsets.only(left: 26.h),
                  padding: EdgeInsets.symmetric(vertical: 25.v),
                  decoration: AppDecoration.fillOnSecondaryContainer,
                  child: SizedBox(
                      width: 162.h,
                      child: Text("rating",
                          maxLines: null,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge)))
            ])));
  }

  /// Section Widget
  Widget _buildPrice(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: Padding(
            padding: EdgeInsets.only(left: 27.h),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              CustomImageView(
                  imagePath: ImageConstant.imgEllipse5,
                  height: 50.adaptSize,
                  width: 50.adaptSize,
                  radius: BorderRadius.circular(25.h),
                  margin: EdgeInsets.only(top: 15.v, bottom: 24.v)),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: 24.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 43.h, vertical: 25.v),
                      decoration: AppDecoration.fillOnSecondaryContainer,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 6.v),
                            SizedBox(
                                width: 166.h,
                                child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: "669.00",
                                          style: theme.textTheme.bodyLarge!
                                              .copyWith(
                                                  decoration: TextDecoration
                                                      .lineThrough)),
                                      TextSpan(
                                          text: " 483.00 (27% off)\n",
                                          style: theme.textTheme.bodyLarge)
                                    ]),
                                    textAlign: TextAlign.center))
                          ]))),
              Container(
                  margin: EdgeInsets.only(left: 26.h),
                  padding: EdgeInsets.symmetric(vertical: 24.v),
                  decoration: AppDecoration.fillOnSecondaryContainer,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 3.v),
                        SizedBox(
                            width: 162.h,
                            child: Text("rating",
                                maxLines: null,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyLarge))
                      ]))
            ])));
  }

  /// Section Widget
  Widget _buildArrowRight(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 10.h),
        child: IntrinsicWidth(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
              height: 232.v,
              width: 223.h,
              child: Stack(alignment: Alignment.bottomRight, children: [
                CustomImageView(
                    // imagePath: ImageConstant.imgArrowRight,
                    height: 15.v,
                    width: 14.h,
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.only(right: 46.h, bottom: 21.v)),
                CustomImageView(
                    // imagePath: ImageConstant.imgVectorPrimarycontainer,
                    height: 15.adaptSize,
                    width: 15.adaptSize,
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.only(right: 82.h, bottom: 42.v)),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        height: 232.v,
                        width: 198.h,
                        decoration: BoxDecoration(
                            color: theme.colorScheme.onSecondaryContainer
                                .withOpacity(0.24),
                            borderRadius: BorderRadius.circular(20.h)))),
                Padding(
                    padding: EdgeInsets.only(left: 11.h),
                    child: _buildNinetySix(context,
                        description:
                            "Product name: Dell inspiron 16\nSource: Amazon\nPrice: 17,000Performance: 2% \n\n\n"))
              ])),
          Container(
              height: 232.v,
              width: 223.h,
              margin: EdgeInsets.only(left: 23.h),
              child: Stack(alignment: Alignment.bottomRight, children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        height: 232.v,
                        width: 198.h,
                        decoration: BoxDecoration(
                            color: theme.colorScheme.onSecondaryContainer
                                .withOpacity(0.24),
                            borderRadius: BorderRadius.circular(20.h)))),
                CustomImageView(
                    // imagePath: ImageConstant.imgVectorPrimarycontainer,
                    height: 15.adaptSize,
                    width: 15.adaptSize,
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.only(right: 73.h, bottom: 43.v)),
                CustomImageView(
                    // imagePath: ImageConstant.imgArrowRight,
                    height: 15.v,
                    width: 14.h,
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.only(right: 34.h, bottom: 21.v)),
                Padding(
                    padding: EdgeInsets.only(left: 11.h),
                    child: _buildNinetySix(context,
                        description:
                            "Product name: Dell inspiron 16\nSource: Amazon\nPrice: 20,000Performance: 10% \n\n\n"))
              ]))
        ])));
  }

  /// Common widget
  Widget _buildNinetySix(
    BuildContext context, {
    required String description,
  }) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
              // imagePath: ImageConstant.img1487x90,
              height: 87.v,
              width: 90.h,
              radius: BorderRadius.circular(20.h),
              margin: EdgeInsets.only(left: 36.h)),
          SizedBox(height: 10.v),
          SizedBox(
              width: 212.h,
              child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Product name: ",
                        style: theme.textTheme.titleMedium),
                    TextSpan(
                      text: "Dell inspiron 16\n",
                      // style: CustomTextStyles.titleMedium16
                    ),
                    TextSpan(
                        text: "Source: ", style: theme.textTheme.titleMedium),
                    TextSpan(
                      text: "Amazon\n",
                      // style: CustomTextStyles.titleMedium16
                    ),
                    TextSpan(
                        text: "Price: 20,000Performance: 10% \n\n",
                        style: theme.textTheme.titleMedium),
                    TextSpan(text: "\n", style: theme.textTheme.bodyLarge)
                  ]),
                  textAlign: TextAlign.left))
        ]);
  }

  onTapBasilMenuOutline(BuildContext context) {
    // TODO: implement Actions
  }
}
