import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qarenly/common/widgets/app_bar/appbar_leading_image.dart';
import 'package:qarenly/common/widgets/app_bar/appbar_title_searchview.dart';
import 'package:qarenly/common/widgets/app_bar/appbar_trailing_image.dart';
import 'package:qarenly/common/widgets/app_bar/custom_app_bar.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/presentation/homepage_screen/widgets/userprofile_item_widget.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  late TextEditingController searchController;
  late ScrollController _scrollController;
  late Timer _timer;
  int _currentIndex = 0;

  void _scrollNext() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % 3;
    });

    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final pixels = _scrollController.position.pixels;
    if (pixels >= maxScroll) {
      _scrollController.jumpTo(0);
    } else {
      _scrollController.animateTo(
        pixels + MediaQuery.of(context).size.width,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    _scrollController = ScrollController();
    _timer = Timer.periodic(Duration(seconds: 3), (_) {
      _scrollNext();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _scrollController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: Horizontal Scrolling
                SizedBox(height: 5.0),
                _buildHorizontalScrollingSection(),
                // Section 2: Recent Deals
                SizedBox(height: 8.0),
                _buildRecentDealsSection(context),
                // Section 3: Mostly Viewed
                SizedBox(height: 34.0),
                _buildMostlyViewedSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 69.0,
      leading: Row(
        children: [
          AppbarLeadingImage(
            imagePath: ImageConstant.imgEiUser,
            margin: EdgeInsets.only(left: 16.0, top: 7.0, bottom: 1.0),
          ),
        ],
      ),
      centerTitle: false,
      title: Container(
        margin: EdgeInsets.only(left: 5.0, top: 10.0, bottom: 1.0),
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
          margin: EdgeInsets.fromLTRB(6.0, 8.0, 15.0, 1.0),
          onTap: () {
            onTapBasilMenuOutline(context);
          },
        ),
      ],
    );
  }

  Widget _buildHorizontalScrollingSection() {
    _scrollController = ScrollController();
    return Container(
      decoration: AppDecoration.fillPrimary,
      height: 198.0,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: index == _currentIndex ? 1.0 : 0.0,
            child: Container(
              decoration: AppDecoration.fillPrimary,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 2.0),
                  CustomImageView(
                    imagePath: ImageConstant.imgSmartGadgetV3,
                    height: 196.0,
                    width: 351.0,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /*
  Widget _buildHorizontalScrollingSection() {
    _scrollController = ScrollController();

    return Container(
      decoration: AppDecoration.fillPrimary,
      height: 198.0,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            // Wrap the container with another widget
            child: AnimatedOpacity(
              duration: Duration(seconds: 1),
              opacity: index == _currentIndex ? 1.0 : 0.0,
              child: Container(
                decoration: AppDecoration.fillPrimary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 2.0),
                    CustomImageView(
                      imagePath: ImageConstant.imgSmartGadgetV3,
                      height: 196.0,
                      width: 351.0,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  */

  Widget _buildRecentDealsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Deals',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => SizedBox(height: 21.0),
          itemCount: 2,
          itemBuilder: (context, index) => UserprofileItemWidget(),
        ),
      ],
    );
  }

  Widget _buildMostlyViewedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mostly Viewed',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => SizedBox(height: 21.0),
          itemCount: 5,
          itemBuilder: (context, index) => UserprofileItemWidget(),
        ),
      ],
    );
  }

  onTapBasilMenuOutline(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.sideMenuScreen);
  }
}
