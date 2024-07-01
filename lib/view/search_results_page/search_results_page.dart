import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qarenly/common/widgets/ProductcardItemWidgetHome.dart';
import 'package:qarenly/common/widgets/app_bar/app_bar.dart';
import 'package:qarenly/controller/search_controller.dart';
import 'package:qarenly/model/product_model.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';
import 'package:qarenly/routes/app_routes.dart';
import 'package:qarenly/view/search_results_page/filters.dart';

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
    searchController.text = widget.query;
    _scrollController = ScrollController();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {});
    controller = Get.put(SearchResultController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.SeacrhAndApplyFilters(widget.query);
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
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  SizedBox(
                    height: 300,
                  ),
                  Center(
                    child: Text('No Such Product Found'),
                  ),
                ],
              ),
            );
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
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchFiltersPage()));
                //   filterByPriceRange("0", "50");
              },
              child: Text(
                'Filters',
              ),
              style: TextButton.styleFrom(
                foregroundColor: Color(0XFF003049),
                // backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                textStyle: TextStyle(
                    fontSize:
                        20, // Adjust the font size of the text inside the button
                    // fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
            ),
          ],
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
