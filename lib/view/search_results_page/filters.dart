// // search_filters.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qarenly/common/widgets/app_bar/app_bar.dart';
import 'package:get/get.dart';
import 'package:qarenly/controller/filter_controller.dart';
import 'package:qarenly/controller/search_controller.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';
import 'package:flutter/material.dart';

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
    // Dispose controllers when the widget is disposed
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
            // Smaller TextField for Lower Bound
            Row(
              children: [
                SizedBox(
                  width: 150, // Set desired width
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
                    style:
                        TextStyle(fontSize: 14), // Adjust font size if needed
                  ),
                ),

                SizedBox(width: 20),

                // Smaller TextField for Upper Bound
                SizedBox(
                  width: 150, // Set desired width
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
                    style:
                        TextStyle(fontSize: 14), // Adjust font size if needed
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
            // Center(
            // child:
            Wrap(
              // alignment: WrapAlignment.center,
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
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage('assets/images/amazon.png'),
                          fit: BoxFit.scaleDown),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (filterController.Sources.contains('jumia')) {
                      filterController.Sources.remove("jumia");
                    } else {
                      filterController.Sources.add("jumia");
                    }
                  },
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage('assets/images/jumia.png'),
                          fit: BoxFit.fitWidth),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (filterController.Sources.contains('sigma')) {
                      filterController.Sources.remove("sigma");
                    } else {
                      filterController.Sources.add("sigma");
                    }
                  },
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage('assets/images/sigma.png'),
                          fit: BoxFit.fitWidth),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (filterController.Sources.contains('noon')) {
                      filterController.Sources.remove("noon");
                    } else {
                      filterController.Sources.add("noon");
                    }
                  },
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/noonwithoutbackground.png'),
                          fit: BoxFit.fitWidth),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Implement your logic for using the entered price range
                    if (filterController.Sources.contains('albadr')) {
                      filterController.Sources.remove("albadr");
                    } else {
                      filterController.Sources.add("albadr");
                    }
                  },
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage('assets/images/albadr.png'),
                          fit: BoxFit.fitWidth),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ],
            ),
            // ),
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
                  // Implement your logic for using the entered price range
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

                  // Use these values for filtering or any other logic
                },
                child: Text('Submit', style: TextStyle(color: Colors.black)),
                // navigator: Navigator.of(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class SearchFiltersPage extends StatelessWidget {
//   SearchController searchController = Get.put(SearchController());
//   AuthenticationRepo authenticationRepo = Get.put(AuthenticationRepo());
//   final TextEditingController lowerBoundController = TextEditingController();
//   final TextEditingController upperBoundController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: BuildAppBar(
//           searchController: searchController,
//           authenticationRepo: authenticationRepo),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(children: [
//           Text(
//             "Price Range",
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           TextField(
//               controller: lowerBoundController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'Lower Bound',
//                 hintText: 'Enter lower bound',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: upperBoundController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'Upper Bound',
//                 hintText: 'Enter upper bound',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement your logic for using the entered price range
//                 final lowerBound = lowerBoundController.text;
//                 final upperBound = upperBoundController.text;
//                 print('Lower Bound: $lowerBound, Upper Bound: $upperBound');
//                 // Use these values for filtering or any other logic
//               },
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//    // );

//       //     Wrap(
//       //       spacing: 8.0, // Horizontal space between buttons
//       //       runSpacing: 12.0, // Vertical space between rows
//       //       alignment:
//       //           WrapAlignment.start, // Align items to the start of each line
//       //       children: [
//       //         ElevatedButton(
//       //           onPressed: () {
//       //             //   filterByPriceRange("0", "50");
//       //           },
//       //           child: Text(
//       //             "Below \50",
//       //             style: TextStyle(
//       //                 color: Colors.black), // Text color of the button
//       //           ),
//       //           style: ElevatedButton.styleFrom(
//       //             backgroundColor: Colors.white,
//       //             minimumSize: Size(110, 50),
//       //             shape: RoundedRectangleBorder(
//       //                 borderRadius: BorderRadius.circular(10)),
//       //             // Set the size of the button
//       //             // You can also adjust other properties such as padding, shape, etc.
//       //           ),
//       //         ),
//       //         ElevatedButton(
//       //           onPressed: () {
//       //             //    filterByPriceRange("50", "100");
//       //           },
//       //           child: Text(
//       //             "\50 - \100",
//       //             style: TextStyle(
//       //                 color: Colors.black), // Text color of the button
//       //           ),
//       //           style: ButtonStyle(
//       //             minimumSize: MaterialStateProperty.all<Size>(
//       //                 Size(110, 40)), // Set the size of the button
//       //             // You can also adjust other properties such as padding, shape, etc.
//       //           ),
//       //         ),
//       //         ElevatedButton(
//       //           onPressed: () {
//       //             // filterByPriceRange("100", "200");
//       //           },
//       //           child: Text(
//       //             "\100 - \200",
//       //             style: TextStyle(
//       //                 color: Colors.black), // Text color of the button
//       //           ),
//       //           style: ButtonStyle(
//       //             minimumSize: MaterialStateProperty.all<Size>(
//       //                 Size(110, 40)), // Set the size of the button
//       //             // You can also adjust other properties such as padding, shape, etc.
//       //           ),
//       //         ),
//       //         ElevatedButton(
//       //           onPressed: () {
//       //             // filterByPriceRange("200", "9999");
//       //           },
//       //           child: Text(
//       //             "Above \200",
//       //             style: TextStyle(
//       //                 color: Colors.black), // Text color of the button
//       //           ),
//       //           style: ButtonStyle(
//       //             minimumSize: MaterialStateProperty.all<Size>(
//       //                 Size(110, 40)), // Set the size of the button
//       //             // You can also adjust other properties such as padding, shape, etc.
//       //           ),
//       //         ),
//       //       ],
//       //     ),
//     //  ]),
//        );
//   //  );
//   }
// }
