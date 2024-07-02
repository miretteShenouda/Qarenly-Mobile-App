import 'package:flutter/material.dart';
import 'package:qarenly/common/widgets/app_bar/app_bar.dart';
import 'package:get/get.dart';
import 'package:qarenly/controller/filter_controller.dart';
import 'package:qarenly/controller/search_controller.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';

class SearchFiltersPage extends StatefulWidget {
  @override
  _SearchFiltersPageState createState() => _SearchFiltersPageState();
}

class _SearchFiltersPageState extends State<SearchFiltersPage> {
  SearchController searchController = Get.put(SearchController());
  AuthenticationRepo authenticationRepo = Get.put(AuthenticationRepo());
  final TextEditingController lowerBoundController = TextEditingController();
  final TextEditingController upperBoundController = TextEditingController();
  FilterController filterController = Get.put(FilterController());
  SearchResultController searchResultController =
      Get.put(SearchResultController());

  @override
  void dispose() {
    lowerBoundController.dispose();
    upperBoundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppBar(
          searchController: searchController,
          authenticationRepo: authenticationRepo),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Price",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Text(
              "Enter Price Range...",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  width: 150,
                  child: TextField(
                    controller: lowerBoundController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Lower Bound',
                      hintText: 'Enter lower bound',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: 150,
                  child: TextField(
                    controller: upperBoundController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Colors.black,
                      labelText: 'Upper Bound',
                      hintText: 'Enter upper bound',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Sources",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Text(
              "Choose your Seller...",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 40.0,
              runSpacing: 10.0,
              children: [
                GestureDetector(
                  onTap: () {
                    if (filterController.Sources.contains('amazon')) {
                      filterController.Sources.remove("amazon");
                    } else {
                      filterController.Sources.add("amazon");
                    }
                  },
                  child: Obx(() {
                    bool isChecked =
                        filterController.Sources.contains("amazon");
                    return Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage('assets/images/amazon.png'),
                            fit: BoxFit.scaleDown),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: isChecked
                          ? Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 20.0,
                              ),
                            )
                          : SizedBox.shrink(),
                    );
                  }),
                ),
                GestureDetector(
                  onTap: () {
                    if (filterController.Sources.contains('jumia')) {
                      filterController.Sources.remove("jumia");
                    } else {
                      filterController.Sources.add("jumia");
                    }
                  },
                  child: Obx(() {
                    bool isChecked = filterController.Sources.contains("jumia");
                    return Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage('assets/images/jumia.png'),
                            fit: BoxFit.scaleDown),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: isChecked
                          ? Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 20.0,
                              ),
                            )
                          : SizedBox.shrink(),
                    );
                  }),
                ),
                GestureDetector(
                  onTap: () {
                    if (filterController.Sources.contains('sigma')) {
                      filterController.Sources.remove("sigma");
                    } else {
                      filterController.Sources.add("sigma");
                    }
                  },
                  child: Obx(() {
                    bool isChecked = filterController.Sources.contains("sigma");
                    return Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage('assets/images/sigma.png'),
                            fit: BoxFit.scaleDown),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: isChecked
                          ? Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 20.0,
                              ),
                            )
                          : SizedBox.shrink(),
                    );
                  }),
                ),
                GestureDetector(
                  onTap: () {
                    if (filterController.Sources.contains('noon')) {
                      filterController.Sources.remove("noon");
                    } else {
                      filterController.Sources.add("noon");
                    }
                  },
                  child: Obx(() {
                    bool isChecked = filterController.Sources.contains("noon");
                    return Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/noonwithoutbackground.png'),
                            fit: BoxFit.scaleDown),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: isChecked
                          ? Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 20.0,
                              ),
                            )
                          : SizedBox.shrink(),
                    );
                  }),
                ),
                GestureDetector(
                  onTap: () {
                    if (filterController.Sources.contains('albadr')) {
                      filterController.Sources.remove("albadr");
                    } else {
                      filterController.Sources.add("albadr");
                    }
                  },
                  child: Obx(() {
                    bool isChecked =
                        filterController.Sources.contains("albadr");
                    return Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage('assets/images/albadr.png'),
                            fit: BoxFit.scaleDown),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: isChecked
                          ? Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 20.0,
                              ),
                            )
                          : SizedBox.shrink(),
                    );
                  }),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(150, 40),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (!lowerBoundController.text.isEmpty &&
                      !upperBoundController.text.isEmpty) {
                    final double lowerBound =
                        double.parse(lowerBoundController.text);
                    final double upperBound =
                        double.parse(upperBoundController.text);
                    filterController.priceFilterLowerBound.value = lowerBound;
                    filterController.priceFilterUpperBound.value = upperBound;
                  }
                  searchResultController.applyFilters();
                  Navigator.pop(context);
                },
                child: Text('Submit', style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
