import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qarenly/model/product_model.dart';
import 'package:qarenly/routes/app_routes.dart';

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

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    _scrollController = ScrollController();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {});
    controller = Get.put(SearchResultController());
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
        appBar: BuildAppBar(searchController: searchController),
        body: FutureBuilder(
            future: controller.searchLaptops(widget.query),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child:
                        CircularProgressIndicator()); // Display a loading indicator
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section 3: Mostly Viewed
                        const SizedBox(height: 34.0),
                        _buildMostlyViewedSection(snapshot),
                      ],
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }

  Widget _buildMostlyViewedSection(AsyncSnapshot<Object?> snapshot) {
    final resultList = snapshot.data as RxList<Product>;
    print(resultList[0].imageUrl);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Search Result',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 21.0),
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
