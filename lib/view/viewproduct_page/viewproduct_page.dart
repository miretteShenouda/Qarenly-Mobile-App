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
    // ratings = List<int?>.filled(_controller.documentData.value[''].length, null);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.initDependencies(context);
      _controller.initSavedState();
      _controller.getSimilarProducts();
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
                                        // borderRadius: BorderRadius.circular(16.0),
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
                              SizedBox(width: 10),
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
          text,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget getColumnContent(
      int colIndex, Map<String, dynamic> documentData, int rowIndex) {
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
                launchURL(documentData['sources'][rowIndex]['URL']);
              },
              child: Image.asset(
                'assets/images/${documentData['sources'][rowIndex]['website']}.png',
                height: 30.0,
              ),
            ),
          ),
        );
      case 1:
        return buildRoundedContainer(
          child: documentData['sources'][rowIndex]['discounted_price'] != null
              ? RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: documentData['sources'][rowIndex]['price']
                            .toString(),
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      TextSpan(
                        text:
                            " ${documentData['sources'][rowIndex]['discounted_price'].toString()}",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                )
              : Text(
                  documentData['sources'][rowIndex]['price'].toString(),
                  style: TextStyle(color: Colors.black),
                ),
        );
      case 2:
        return buildRoundedContainer(
          child: Text(
              documentData['sources'][rowIndex]['stock_status'].toString()),
        );
      case 3:
        return buildRoundedContainer(
          child: Text(formatTimestamp(
              documentData['sources'][rowIndex]['last_instock'])),
        );
      case 4:
        return buildRoundedContainer(
          child: Text(documentData['sources'][rowIndex]['rating'].toString()),
        );
      case 5:
        return buildRoundedContainer(
          child: DropdownButton<int>(
            value: ratings[rowIndex],
            hint: Text('Rate'),
            items: [1, 2, 3, 4, 5].map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
            onChanged: (int? newValue) {
              setState(() {
                ratings[rowIndex] = newValue;
              });
            },
          ),
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget buildRoundedContainer({required Widget child}) {
    return Container(
      height: 30.0,
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 48, 73, 0.24),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Center(child: child),
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
}
