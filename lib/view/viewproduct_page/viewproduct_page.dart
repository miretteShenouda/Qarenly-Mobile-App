import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qarenly/common/widgets/ProductcardItemWidgetBenchmarking.dart';
import 'package:qarenly/common/widgets/app_bar/app_bar.dart';
import 'package:qarenly/controller/viewProduct_controller.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/widgets/line_chart.dart';

class ViewproductPage extends StatefulWidget {
  ViewproductPage({Key? key}) : super(key: key);
  // final controller = Get.put(ViewProductController());
  // final List<Map<String, dynamic>> sources;

  // ViewproductPage({required this.sources});

  @override
  _ViewProductPageState createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewproductPage> {
  late ViewProductController _controller = Get.put(ViewProductController());
  AuthenticationRepo _authenticationRepo = Get.put(AuthenticationRepo());
  late List<int?> ratings = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

// Function to parse and format the timestamp
  String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) {
      return 'N/A'; // Return a default value if timestamp is null
    }

    try {
      // Convert Timestamp to DateTime
      DateTime date = timestamp.toDate();

      // Define the output format
      DateFormat outputFormat = DateFormat('dd-MM-yyyy');

      // Format the date
      return outputFormat.format(date);
    } catch (e) {
      return 'Invalid Date'; // Handle parsing errors
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.onInit();
    // ratings = List<int?>.filled(_controller.documentData.value[''].length, null);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.initDependencies(context);
      _controller.initSavedState();
      _controller.getSimilarProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  ratings =
                      List<int?>.filled(documentData['sources'].length, null);
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
                      // Table(
                      //     defaultVerticalAlignment:
                      //         TableCellVerticalAlignment.middle,
                      Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Table(
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              columnWidths: {
                                0: FixedColumnWidth(
                                    100.0), // Adjust width as needed
                                1: FixedColumnWidth(120.0),
                                2: FixedColumnWidth(120.0),
                                3: FixedColumnWidth(120.0),
                                4: FixedColumnWidth(120.0),
                                5: FixedColumnWidth(120.0),
                              },
                              children: [
                                // Header row with column titles
                                TableRow(
                                  children: [
                                    TableCell(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            'Image',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            'Price',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            'Stock Status',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            'Last in Stock',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            'Rating',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            'Your Rating',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
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
                                          // child: Center(
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
                                                  width:
                                                      2.0, // Adjust border width
                                                ),
                                                borderRadius: BorderRadius.circular(
                                                    100.0), // Match border radius
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  // Use URL Launcher to open the link
                                                  launchURL(
                                                      documentData['sources']
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
                                            child: Center(
                                              child: documentData['sources']
                                                              [index][
                                                          'discounted_price'] !=
                                                      null
                                                  ? RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: documentData[
                                                                        'sources']
                                                                    [
                                                                    index]['price']
                                                                .toString(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              decoration:
                                                                  TextDecoration
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
                                                      documentData['sources']
                                                              [index]['price']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
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
                                          // Wrap content in a Container
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(0, 48, 73,
                                                  0.24), // Set grey background color
                                            ),
                                            child: Center(
                                              child: Text(
                                                documentData['sources'][index]
                                                        ['stock_status']
                                                    .toString(), // Add price field
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      //cell for last_instock
                                      TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          // Wrap content in a Container
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(0, 48, 73,
                                                  0.24), // Set grey background color
                                            ),
                                            child: Center(
                                              child: Text(
                                                formatTimestamp(documentData[
                                                        'sources'][index][
                                                    'last_instock']), // Add price field
                                              ),
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
                                            child: Center(
                                              child: Text(
                                                documentData['sources'][index]
                                                        ['rating']
                                                    .toString(), // Add price field
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      // //cell for user rating input
                                      // TableCell(
                                      //   //rate the source
                                      //   verticalAlignment:
                                      //       TableCellVerticalAlignment.middle,
                                      //   child: Padding(
                                      //     padding: EdgeInsets.all(8.0),
                                      //     child: Container(
                                      //       // Wrap content in a Container
                                      //       decoration: BoxDecoration(
                                      //         color: Color.fromRGBO(0, 48, 73,
                                      //             0.24), // Set grey background color
                                      //       ),
                                      //       child: Center(
                                      //         child: Text(
                                      //           "enter rating", // Add price field
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      // Cell for user rating input
                                      // Cell for user rating input
                                      TableCell(
                                        verticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  0, 48, 73, 0.24),
                                            ),
                                            child: Center(
                                              child: DropdownButton<int>(
                                                value: ratings[index],
                                                hint: Text('Rate'),
                                                items: [1, 2, 3, 4, 5]
                                                    .map((int value) {
                                                  return DropdownMenuItem<int>(
                                                    value: value,
                                                    child:
                                                        Text(value.toString()),
                                                  );
                                                }).toList(),
                                                onChanged: (int? newValue) {
                                                  setState(() {
                                                    ratings[index] = newValue;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Scroll horizontally to see more',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(Icons.arrow_right_alt),
                              ],
                            ),
                          ),
                          Container(
                            height:
                                300, // Set a fixed height for LineChartSample1
                            child: Center(
                              child: LineChartSample1(
                                dates: (documentData['dates'] as List<dynamic>)
                                    .map((date) => (date as Timestamp).toDate())
                                    .toList(),
                                prices: documentData['lowest_prices'],
                              ),
                            ),
                          ),
                          Container(
                            height: 250.0,
                            child: ListView.separated(
                              shrinkWrap:
                                  true, // No need to shrink wrap for horizontal scrolling
                              scrollDirection: Axis.horizontal,
                              physics:
                                  BouncingScrollPhysics(), // Allow the list to scroll horizontally
                              separatorBuilder: (context, index) => SizedBox(
                                  width:
                                      10), // Use width for horizontal separation
                              itemCount: _controller.similarItems.length,
                              itemBuilder: (context, index) {
                                final product = _controller.similarItems[index];
                                return ProductcardItemWidgetBenchmarking(
                                  product: product,
                                  comparison: product.comparison ??
                                      "", // Pass comparison value

                                  // Ensure comparison is passed correctly
                                );
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  );
                } else {
                  return Center(child: Text('Product not found.'));
                }
              },
            ),
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
