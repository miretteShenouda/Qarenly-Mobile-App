import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qarenly/common/widgets/ProductcardItemWidgetBenchmarking.dart';
import 'package:qarenly/common/widgets/app_bar/app_bar.dart';
import 'package:qarenly/controller/viewProduct_controller.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/widgets/line_chart.dart';

class ViewproductPage extends StatefulWidget {
  ViewproductPage({Key? key}) : super(key: key);
  final controller = Get.put(ViewProductController());

  @override
  _ViewProductPageState createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewproductPage> {
  late ViewProductController _controller = Get.put(ViewProductController());
  AuthenticationRepo _authenticationRepo = Get.put(AuthenticationRepo());
  // late ScrollController _scrollController;
  // int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller.onInit();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.initDependencies(context);
  }

  @override
  Widget build(BuildContext context) {
    _controller.initSavedState();
    _controller.getSimilarProducts();
    print("hi caty");
    print(_controller.similarItems.toList());
    return SafeArea(
      child: Scaffold(
        appBar: BuildAppBar(
          searchController: _controller.searchController,
          authenticationRepo: _authenticationRepo,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child:
                // Column(children: [
                Obx(
              () {
                if (_controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (_controller.documentData.value != null) {
                  final documentData = _controller.documentData.value!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Product Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25)),
                          Row(
                            children: [
                              SizedBox(width: 10),
                              Align(
                                alignment: Alignment.topRight,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await _controller.toggleSavedItem();
                                    setState(() {
                                      _controller.isSaved =
                                          !_controller.isSaved;
                                    });
                                  },
                                  child: Icon(
                                    _controller.isSaved
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.black,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 10),
                      Text(
                        documentData['name'].toString(),
                        maxLines: 2,
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Image(
                          image: NetworkImage(
                              documentData['image_URL'].toString()),
                          width: 300,
                          height: 300,
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Text("Product description",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(documentData['desc'].toString()),
                      SizedBox(
                        height: 20,
                      ),

                      Text("Sources",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),

                      //this is the table of scources
                      Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            // Header row with column titles
                            TableRow(
                              // decoration: BoxDecoration(
                              //   // color: Colors.grey[
                              //   //     300], // Background color for the header row
                              // ),
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Image',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Price',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Rating',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Stock Status',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'User Rating',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            ...List.generate(
                              documentData['sources']
                                  .length, // Generate rows based on list length
                              (index) => TableRow(
                                children: [
                                  //cell for image and url
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            100.0), // Adjust radius for size
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(0, 48, 73,
                                                0.0), // Set background color (optional)
                                            border: Border.all(
                                              color: Colors
                                                  .black, // Change border color as needed
                                              width: 2.0, // Adjust border width
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                100.0), // Match border radius
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              // Use URL Launcher to open the link
                                              launchURL(documentData['sources']
                                                  [index]['URL']);
                                            },
                                            child: Image.asset(
                                              'assets/images/amazon.png', // Replace with your actual logo widget or image provider
                                              height:
                                                  30.0, // Adjust height for logo size
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  //cell for price and discounted price
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        // Wrap content in a Container
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(0, 48, 73,
                                              0.24), // Set grey background color
                                        ),
                                        child: documentData['sources'][index]
                                                    ['discounted_price'] !=
                                                null
                                            ? RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: documentData[
                                                                  'sources']
                                                              [index]['price']
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        decoration: TextDecoration
                                                            .lineThrough, // Strike-through style
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          " ${documentData['sources'][index]['discounted_price'].toString()}",
                                                      style: TextStyle(
                                                        color: Colors
                                                            .red, // Change color for discounted price
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Text(
                                                documentData['sources'][index]
                                                        ['price']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                      ),
                                    ),
                                  ),

                                  //cell for scraped rating
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        // Wrap content in a Container
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(0, 48, 73,
                                              0.24), // Set grey background color
                                        ),
                                        child: Text(
                                          documentData['sources'][index]
                                                  ['rating']
                                              .toString(), // Add price field
                                        ),
                                      ),
                                    ),
                                  ),

                                  //cell for stock_status
                                  TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        // Wrap content in a Container
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(0, 48, 73,
                                              0.24), // Set grey background color
                                        ),
                                        child: Text(
                                          documentData['sources'][index]
                                                  ['stock_status']
                                              .toString(), // Add price field
                                        ),
                                      ),
                                    ),
                                  ),

                                  //cell for user rating input
                                  TableCell(
                                    //rate the source
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        // Wrap content in a Container
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(0, 48, 73,
                                              0.24), // Set grey background color
                                        ),
                                        child: Text(
                                          "enter rating", // Add price field
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                      Container(
                        height: 300, // Set a fixed height for LineChartSample1
                        child: Center(
                            // child: LineChartSample1(
                            //   dates: (documentData['dates'] as List<dynamic>)
                            //       .map((date) => (date as Timestamp).toDate())
                            //       .toList(),
                            //   prices: documentData['lowest_prices'],
                            // ),
                            ),
                      ),
                      ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 21.0),
                          itemCount: _controller.similarItems.length,
                          itemBuilder: (context, index) =>
                              ProductcardItemWidgetBenchmarking(
                                product: _controller.similarItems[index],
                              ))
                    ],
                  );
                } else {
                  return Center(child: Text('Product not found.'));
                }
              },
            ),
            //    ]
            //   child:
          ),
        ),
      ),
      //  ),
    );
  }

  // Function to launch URL
  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

// void _scrollNext() {
//   if (_controller.documentData.value == null) return;

//   setState(() {
//     // _currentIndex = (_currentIndex + 1) % _controller.documentData.value!['sources']!.length;
//   });

//   if (!_scrollController.hasClients) return;

//   final itemWidth = MediaQuery.of(context).size.width;
//   final targetScroll = _currentIndex * itemWidth;

//   _scrollController.animateTo(
//     targetScroll,
//     duration: const Duration(milliseconds: 500),
//     curve: Curves.easeInOut,
//   );
// }
