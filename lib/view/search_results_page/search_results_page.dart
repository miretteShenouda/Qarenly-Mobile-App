import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:qarenly/model/product_model.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';
import 'package:qarenly/routes/app_routes.dart';
import 'package:qarenly/view/search_results_page/filters.dart';

import '../../common/widgets/ProductcardItemWidgetHome.dart';
import '../../common/widgets/app_bar/app_bar.dart';
import '../../controller/search_controller.dart';

class SearchResultsPage extends StatefulWidget {
  String query;

  SearchResultsPage({Key? key, required this.query}) : super(key: key);

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  late TextEditingController searchController;
  late ScrollController _scrollController;
  late Timer _timer;
  int _currentIndex = 0;
  late SearchResultController controller;

  final authentiationRepo = Get.put(AuthenticationRepo());

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    _scrollController = ScrollController();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {});
    controller = Get.put(SearchResultController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.searchProducts(widget.query);
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
          authenticationRepo: authentiationRepo,
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(
                child:
                    CircularProgressIndicator()); // Display a loading indicator
          } else if (controller.searchReturn.isEmpty) {
            return Center(child: Text('No Such Product Found'));
            // return Text('Error: ${snapshot.error}');
          } else {
            print("is loading: ${controller.isLoading.value}");
            print('length: ${controller.searchReturn.length}');
            print("searchReturn ${controller.searchReturn}");
            return SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section 3: Mostly Viewed
                    const SizedBox(height: 10.0),
                    _buildMostlyViewedSection(controller.searchReturn),
                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }

  Widget _buildMostlyViewedSection(List<Product> snapshot) {
    final resultList = snapshot;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Search Result',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              child: Text(
                "Filters",
                style:
                    TextStyle(color: Colors.white), // Text color of the button
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.orange),
                minimumSize: MaterialStateProperty.all<Size>(
                    Size(110, 50)), // Set the size of the button
                // You can also adjust other properties such as padding, shape, etc.
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchFiltersPage()));
                //   filterByPriceRange("0", "50");
              },
            ),
          ],
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Wrap(
              spacing: 10.0,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //  children: [

                // ElevatedButton(
                //   onPressed: () {
                //     //   filterByPriceRange("0", "50");
                //   },
                //   child: Text(
                //     "Below \50",
                //     style: TextStyle(
                //         color: Colors.black), // Text color of the button
                //   ),
                //   style: ButtonStyle(
                //     minimumSize: MaterialStateProperty.all<Size>(
                //         Size(110, 40)), // Set the size of the button
                //     // You can also adjust other properties such as padding, shape, etc.
                //   ),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     //    filterByPriceRange("50", "100");
                //   },
                //   child: Text(
                //     "\50 - \100",
                //     style: TextStyle(
                //         color: Colors.black), // Text color of the button
                //   ),
                //   style: ButtonStyle(
                //     minimumSize: MaterialStateProperty.all<Size>(
                //         Size(110, 40)), // Set the size of the button
                //     // You can also adjust other properties such as padding, shape, etc.
                //   ),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     // filterByPriceRange("100", "200");
                //   },
                //   child: Text(
                //     "\100 - \200",
                //     style: TextStyle(
                //         color: Colors.black), // Text color of the button
                //   ),
                //   style: ButtonStyle(
                //     minimumSize: MaterialStateProperty.all<Size>(
                //         Size(110, 40)), // Set the size of the button
                //     // You can also adjust other properties such as padding, shape, etc.
                //   ),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     // filterByPriceRange("200", "9999");
                //   },
                // child: Text(
                //   "Above \200",
                //   style: TextStyle(
                //       color: Colors.black), // Text color of the button
                // ),
                // style: ButtonStyle(
                //   minimumSize: MaterialStateProperty.all<Size>(
                //       Size(110, 40)), // Set the size of the button
                //   // You can also adjust other properties such as padding, shape, etc.
                // ),
                // ),
              ],
            )
            //  ]),
            ),
        const SizedBox(height: 10.0),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 10.0),
          itemCount: resultList.length,
          itemBuilder: (context, index) => ProductcardItemWidgetHome(
            product: resultList[index],
            // homePageController: homeController,
          ),
        ),
      ],
    );
  }

  onTapBasilMenuOutline(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.sideMenuScreen);
  }
}
