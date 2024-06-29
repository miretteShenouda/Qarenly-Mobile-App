import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qarenly/common/theme/app_decoration.dart';
import 'package:qarenly/common/widgets/ProductcardItemWidgetHome.dart';
import 'package:qarenly/common/widgets/app_bar/app_bar.dart';
import 'package:qarenly/controller/filter_controller.dart';
import 'package:qarenly/controller/homePage_controller.dart';
import 'package:qarenly/controller/notification_controller.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';
import 'package:url_launcher/url_launcher.dart';

// import '../../common/theme/app_decoration.dart';
// import '../../common/widgets/ProductcardItemWidgetHome.dart';
// import '../../common/widgets/app_bar/app_bar.dart';
// import '../../controller/homePage_controller.dart';

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
                const SizedBox(height: 7.0),
                _buildExploreSection(),
                // Section 3: Mostly Viewed
                const SizedBox(height: 7.0),
                _buildRecommendedSection(context),
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
                child: Text(
                  'See More',
                ),
                style: TextButton.styleFrom(
                  foregroundColor: Color(0XFF003049),
                  // backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  textStyle: TextStyle(
                      fontSize:
                          13, // Adjust the font size of the text inside the button
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
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
                  //launchURL("https://www.google.com/");
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 5.0), // Add margin for spacing between items
                  width: MediaQuery.of(context).size.width -
                      10.0, // Adjust for margin
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
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 7.0),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 14.0),
          itemCount: controller.recommendedItems.length,
          itemBuilder: (context, index) => ProductcardItemWidgetHome(
            product: controller.recommendedItems[index],
            // homePageController: controller,
          ),
        ),
      ],
    );
  }

  Widget _buildExploreSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Explore',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14.0),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 14.0),
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
  final HomePageController controller =
      Get.find(); // Fetch the already created HomePageController instance
  late TextEditingController searchController = TextEditingController();
  final filterController =
      Get.put(FilterController()); // Initialize FilterController

  AuthenticationRepo _authenticationRepo = Get.put(AuthenticationRepo());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BuildAppBar(
          searchController: searchController,
          authenticationRepo: _authenticationRepo,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recent Deals',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7.0),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: controller.recentDeals.length,
                  itemBuilder: (context, index) {
                    final deal = controller.recentDeals[index];
                    final imageUrl = deal.imageUrl;
                    final name = deal.name; // Assuming you have a name field

                    return GestureDetector(
                      onTap: () {
                        launchURL(deal.sources[0]["URL"].toString());
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Image.network(
                                imageUrl,
                                width: 70,
                                height: 70,
                                fit: BoxFit.fill,
//
                              ),
                              const SizedBox(width: 14.0),
                              Expanded(
                                child: Text(name,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    maxLines: 3),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
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
      Get.snackbar("Error Launching URL", "Error launching URL: $e",
          colorText: Colors.black,
          messageText: Text(
            "Error launching URL: $e",
            style: TextStyle(
              fontSize: 16.0, // Adjust the font size as needed
              fontWeight: FontWeight.bold, // Adjust the font weight as needed
            ),
          ));
    }
  }
}
