import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qarenly/controller/filter_controller.dart';
import 'package:qarenly/controller/notification_controller.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/theme/app_decoration.dart';
import '../../common/widgets/ProductcardItemWidgetHome.dart';
import '../../common/widgets/app_bar/app_bar.dart';
import '../../controller/homePage_controller.dart';

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
  final filterController =
      Get.put(FilterController()); // Initialize FilterController

  AuthenticationRepo _authenticationRepo = Get.put(AuthenticationRepo());
  NotificationController notificationController =
      Get.put(NotificationController());

  void _scrollNext() {
    if (controller.products.isEmpty) return; // Add this check
    setState(() {
      _currentIndex = (_currentIndex + 1) % controller.products.length;
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
    // Listen for filter changes
    filterController.filter.listen((_) {
      controller.fetchFilteredProducts();
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
        appBar: BuildAppBar(
          searchController: searchController,
          authenticationRepo: _authenticationRepo,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: Horizontal Scrolling
                const SizedBox(height: 5.0),
                _buildHorizontalScrollingSection(),
                // Section 2: Recent Deals
                const SizedBox(height: 8.0),
                _buildRecommendedSection(context),
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
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    'Recent Deals',
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    ),
    ),
    TextButton(
    onPressed: () {
    // Navigate to the new page
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => MoreDealsPage(),
    ),
    );
    },
    child: Text('See More'),
    ),
    ],
    ),
    ),
          Container(
    decoration: AppDecoration.fillPrimary,
    height: 198.0,
    child: ListView.builder(
    controller: _scrollController,
    scrollDirection: Axis.horizontal,
    itemCount: controller.recentDeals.length,
    itemBuilder: (context, index) {
    final deal = controller.recentDeals[index];
    final imageUrl = deal.imageUrl;

    return GestureDetector(
    onTap: () {
    launchURL(deal.sources[0]["URL"].toString());
    },
    child: Container(
    margin: const EdgeInsets.symmetric(horizontal: 5.0), // Add margin for spacing between items
    width: MediaQuery.of(context).size.width - 10.0, // Adjust for margin
    child: Image.network(
    imageUrl,
    fit: BoxFit.scaleDown,
    ),
    ),
    );
    },
    ),
    ),
        ],
    );
  }
  Future<void> launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(Uri.encodeFull(url));
      print('Parsed URI: $uri'); // Debugging statement

      if (await canLaunch(uri.toString())) {
        print('Can launch URL: $uri'); // Debugging statement
        await launch(uri.toString());
      } else {
        print('Could not launch $uri'); // Debugging statement
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      print('Error launching URL: $e');
      // Optionally, show an error message to the user using a Snackbar or a Dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error launching URL: $e')),
      );
    }
  }
  Widget _buildRecommendedSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recommended For You',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 10.0),
          itemCount: controller.recommendedItems.length,
          itemBuilder: (context, index) => ProductcardItemWidgetHome(
            product: controller.recommendedItems[index],
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
          itemCount: controller.products.length,
          itemBuilder: (context, index) => ProductcardItemWidgetHome(
            product: controller.products[index],
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
class MoreDealsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More Deals'),
      ),
      body: Center(
        child: Text('More deals will be shown here.'),
      ),
    );
  }
}
