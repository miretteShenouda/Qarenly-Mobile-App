import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';

import '../../common/theme/app_decoration.dart';
import '../../common/widgets/ProductcardItemWidgetHome.dart';
import '../../common/widgets/app_bar/app_bar.dart';
import '../../controller/homePage_controller.dart';
import 'package:get/get.dart';

class HomepageScreen extends StatefulWidget {
  HomepageScreen(User user, {Key? key}) : super(key: key);

  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  late TextEditingController searchController;
  late ScrollController _scrollController;
  late Timer _timer;
  int _currentIndex = 0;
  final controller = Get.put(HomePageController());
  AuthenticationRepo _authenticationRepo = Get.put(AuthenticationRepo());

  void _scrollNext() {
    setState(() {
      // _currentIndex = (_currentIndex + 1) % controller.laptops.length;
    });

    if (!_scrollController.hasClients) return;

    //final maxScroll = _scrollController.position.maxScrollExtent;
    final itemWidth = MediaQuery.of(context).size.width;
    final targetScroll = _currentIndex * itemWidth;

    _scrollController.animateTo(
      targetScroll,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    _scrollController = ScrollController();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
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
        appBar: BuildAppBar(searchController: searchController , authenticationRepo: _authenticationRepo,),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: Horizontal Scrolling
                const SizedBox(height: 5.0),
                _buildHorizontalScrollingSection(),
                // Section 2: Recent Deals
                const SizedBox(height: 8.0),
                _buildRecentDealsSection(context),
                // Section 3: Mostly Viewed
                const SizedBox(height: 34.0),
                _buildMostlyViewedSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalScrollingSection() {
    return Container(
      decoration: AppDecoration.fillPrimary,
      height: 198.0,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: controller.laptops.length,
        itemBuilder: (context, index) {
          final imageUrl = controller.laptops[index].imageUrl;
          return Container(
            margin: EdgeInsets.symmetric(
                horizontal: 5.0), // Add margin for spacing between items
            child: Image.network(
              imageUrl,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecentDealsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Deals',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 21.0),
          itemCount: controller.laptops.length,
          itemBuilder: (context, index) => ProductcardItemWidgetHome(
            product: controller.laptops[index],
            // homePageController: controller,
          ),
        ),
      ],
    );
  }

  Widget _buildMostlyViewedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mostly Viewed',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 21.0),
          itemCount: controller.laptops.length,
          itemBuilder: (context, index) => ProductcardItemWidgetHome(
            product: controller.laptops[index],
            // homePageController: controller,
          ),
        ),
      ],
    );
  }

  // onTapBasilMenuOutline(BuildContext context) {
  //   Navigator.pushNamed(context, AppRoutes.sideMenuScreen);
  // }
}
