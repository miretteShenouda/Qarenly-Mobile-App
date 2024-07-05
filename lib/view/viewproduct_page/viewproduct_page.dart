import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  @override
  _ViewProductPageState createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewproductPage> {
  late ViewProductController _controller = ViewProductController();
  AuthenticationRepo _authenticationRepo = Get.put(AuthenticationRepo());
  late List<int?> ratings = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

// Function to parse and format the timestamp
  String formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) {
      return 'N/A';
    }
    try {
      // Convert Timestamp to DateTime
      DateTime date = timestamp.toDate();

      // Define the output format
      DateFormat outputFormat = DateFormat('dd-MM-yyyy');

      // Format the date
      return outputFormat.format(date);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.initDependencies(context);
      _controller.initSavedState();
      _controller.getSimilarProducts();
      _initializeRatings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BuildAppBar(
          searchController: _controller.searchController,
          authenticationRepo: _authenticationRepo,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Obx(
              () {
                if (_controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (_controller.documentData.value != null) {
                  final documentData = _controller.documentData.value!;
                  int? priceChangeIndicator =
                      documentData.containsKey('price_change_indicator')
                          ? documentData['price_change_indicator']
                          : null;
                  // Ensure ratings list is initialized correctly
                  if (ratings.isEmpty && documentData['sources'] != null) {
                    ratings =
                        List<int?>.filled(documentData['sources'].length, null);
                  }

                  // filtering Sources
                  documentData['sources'] =
                      _controller.sortProductSources(documentData['sources']);
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
                                child: _authenticationRepo
                                        .currentUser!.isAnonymous
                                    ? null
                                    : ElevatedButton(
                                        onPressed: () async {
                                          await _controller.toggleSavedItem();
                                        },
                                        child: Icon(
                                          _controller.isSaved.value
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
                      SizedBox(height: 10),
                      Text(documentData['desc'].toString()),
                      SizedBox(height: 20),
                      Text(
                        "Sources",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          columnWidths: {
                            0: FixedColumnWidth(100.0),
                            1: FixedColumnWidth(120.0),
                            2: FixedColumnWidth(120.0),
                            3: FixedColumnWidth(120.0),
                            4: FixedColumnWidth(120.0),
                            5: FixedColumnWidth(120.0),
                          },
                          border: TableBorder.all(
                            color: Color.fromRGBO(0, 48, 73, 0.24),
                          ),
                          children: [
                            TableRow(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 48, 73, 0.14),
                              ),
                              children: [
                                buildHeaderCell('URL'),
                                buildHeaderCell('Price'),
                                buildHeaderCell('Stock Status'),
                                buildHeaderCell('Last in Stock'),
                                buildHeaderCell('Rating'),
                                buildHeaderCell('Your Rating'),
                              ],
                            ),
                            ...List.generate(
                              documentData['sources'].length,
                              (index) => TableRow(
                                children: List.generate(6, (colIndex) {
                                  Color columnColor = colIndex % 2 == 0
                                      ? Colors.transparent
                                      : Color.fromRGBO(0, 48, 73,
                                          0.24); // alternating colors

                                  //creating columns
                                  return TableCell(
                                    verticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: columnColor,
                                      ),
                                      // color: columnColor,
                                      padding: EdgeInsets.all(8.0),
                                      child: getColumnContent(
                                          colIndex, documentData, index),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //scroll note
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Scroll horizontally to see more',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.arrow_right_alt),
                          ],
                        ),
                      ),

                      // Price change indicator message
                      SizedBox(height: 10),
                      priceChangeIndicator != null
                          ? getPriceChangeMessage(priceChangeIndicator)
                          : Text('Price change indicator is not available'),

                      //line chart
                      Container(
                        height: 300,
                        child: Center(
                          child: LineChartSample1(
                            dates: (documentData['dates'] as List<dynamic>)
                                .map((date) => (date as Timestamp).toDate())
                                .toList(),
                            prices: documentData['lowest_prices'],
                          ),
                        ),
                      ),

                      //benchmarking
                      Container(
                        height: 250.0,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 3.0),
                          itemCount: _controller.similarItems.length,
                          itemBuilder: (context, index) {
                            final product = _controller.similarItems[index];
                            return ProductcardItemWidgetBenchmarking(
                              product: product,
                              comparison: product.comparison ?? "",
                            );
                          },
                        ),
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
    );
  }

  Widget buildHeaderCell(String text) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          handleNullValues(text),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget getColumnContent(
      int colIndex, Map<String, dynamic> documentData, int rowIndex) {
    try {
      switch (colIndex) {
        case 0:
          return ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: InkWell(
                onTap: () {
                  launchURL(handleNullValues(
                      documentData['sources'][rowIndex]['URL']));
                },
                child: Image.asset(
                  'assets/images/${handleNullValues(documentData['sources'][rowIndex]['website'])}.png',
                  height: 32.0,
                ),
              ),
            ),
          );
        case 1:
          return buildRoundedContainer(
            child: Center(
              child: documentData['sources'][rowIndex]['discounted_price'] !=
                      null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: handleNullValues(documentData['sources']
                                            [rowIndex]['discounted_price']
                                        .toString() +
                                    '\n'),
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: handleNullValues(documentData['sources']
                                        [rowIndex]['price']
                                    .toString()),
                                style: TextStyle(
                                    color: Colors.red,
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 10.0),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : Text(
                      handleNullValues(documentData['sources'][rowIndex]
                              ['price']
                          .toString()),
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
            ),
          );
        case 2:
          return buildRoundedContainer(
            child: Text(handleStockStatus(
                documentData['sources'][rowIndex]['stock_status'])),
          );
        case 3:
          return buildRoundedContainer(
            child: Text(handleNullTimestamps(
                documentData['sources'][rowIndex]['last_instock'])),
          );
        case 4:
          return buildRoundedContainer(
            child: Text(handleNullValues(
                documentData['sources'][rowIndex]['rating']?.toString())),
          );
        case 5:
          return buildRoundedContainer(
            child: DropdownButton<int>(
              value: ratings[rowIndex],
              hint: Text('Rate'),
              onChanged: (int? newValue) {
                setState(() {
                  ratings[rowIndex] = newValue!;
                });
                updateRating(rowIndex, newValue);
              },
              items: [1, 2, 3, 4, 5].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            ),
          );
        default:
          return SizedBox.shrink();
      }
    } catch (e) {
      debugPrint('Error in getColumnContent: $e');
      return Center(child: Text('Error'));
    }
  }

  Widget buildRoundedContainer({required Widget child}) {
    return Container(
      height: 32.0,
      child: Center(child: child),
    );
  }

  final Widget arrowUpIcon = Icon(Icons.arrow_upward, color: Colors.red);
  final Widget arrowDownIcon = Icon(Icons.arrow_downward, color: Colors.green);

  Widget getPriceChangeMessage(int priceChangeIndicator) {
    Widget message;
    switch (priceChangeIndicator) {
      case -1:
        message = Row(
          children: [
            Text('Expected decrease in price'),
            SizedBox(width: 5),
            Icon(Icons.arrow_downward, color: Colors.green, size: 30),
          ],
        );
        break;
      case 0:
        message = Text('Expected constant price');
        break;
      case 1:
        message = Row(
          children: [
            Text('Expected increase in price'),
            SizedBox(width: 5),
            Icon(Icons.arrow_upward, color: Colors.red, size: 30),
          ],
        );
        break;
      default:
        message = Text('');
    }

    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color.fromRGBO(0, 48, 73, 1), width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Color.fromRGBO(0, 48, 73, 1.0)),
          SizedBox(width: 5),
          Expanded(child: message),
        ],
      ),
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

  String handleStockStatus(bool? stockStatus) {
    if (stockStatus == true) {
      return 'Available';
    } else {
      return 'Not Available';
    }
  }

  String handleNullValues(String? value, {String defaultValue = '—'}) {
    return (value == 'N/A' || value == 'null' || value == null || value.isEmpty)
        ? defaultValue
        : value;
  }

  String handleNullTimestamps(Timestamp? timestamp,
      {String defaultValue = '—'}) {
    if (timestamp == null) {
      return defaultValue;
    }
    try {
      DateTime date = timestamp.toDate();
      DateFormat outputFormat = DateFormat('dd-MM-yyyy');
      return outputFormat.format(date);
    } catch (e) {
      return defaultValue;
    }
  }

  Future<void> updateRating(int rowIndex, int? rating) async {
    try {
      // Get current user ID
      String userId = _authenticationRepo.currentUser!.uid;

      // Create a reference to the product document
      DocumentReference productRef = FirebaseFirestore.instance
          .collection(_controller.productType!)
          .doc(_controller.productId);

      // Fetch the product document to update the specific source in the sources list
      DocumentSnapshot productSnapshot = await productRef.get();
      if (productSnapshot.exists) {
        // Get the product data
        Map<String, dynamic> productData =
            productSnapshot.data() as Map<String, dynamic>;

        // Get the sources list
        List<dynamic> sources = productData['sources'];

        // Update the specific source with the new rating
        Map<String, dynamic> source = sources[rowIndex];
        Map<String, dynamic> usersRatings = source['users_ratings'] ?? {};
        usersRatings[userId] = rating;

        source['users_ratings'] = usersRatings;

        // Update the sources list
        sources[rowIndex] = source;
        await productRef.update({'sources': sources});

        // Update the local ratings list
        setState(() {
          ratings[rowIndex] = rating;
        });

        // Optionally, update the UI or show a confirmation message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Rating updated successfully')),
        );
      } else {
        throw Exception('Product not found');
      }
    } catch (e) {
      print('Error updating rating: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update rating: $e')),
      );
    }
  }

  Future<void> _initializeRatings() async {
    try {
      // Fetch the product document
      DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
          .collection(_controller.productType!)
          .doc(_controller.productId)
          .get();

      if (productSnapshot.exists) {
        // Get the product data
        Map<String, dynamic> productData =
            productSnapshot.data() as Map<String, dynamic>;
        List<dynamic> sources = productData['sources'];

        // Initialize the ratings list
        setState(() {
          ratings = List<int?>.generate(sources.length, (index) {
            Map<String, dynamic> usersRatings =
                sources[index]['users_ratings'] ?? {};
            String userId = _authenticationRepo.currentUser!.uid;
            return usersRatings[userId];
          });
        });
      }
    } catch (e) {
      print('Error initializing ratings: $e');
    }
  }
}
