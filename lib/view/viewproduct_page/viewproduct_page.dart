import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:qarenly/common/widgets/app_bar/app_bar.dart';
import 'package:qarenly/controller/viewProduct_controller.dart';
import 'package:get/get.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';
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
  late ScrollController _scrollController;
  int _currentIndex = 0;
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
    return SafeArea(
      child: Scaffold(
        appBar: BuildAppBar(searchController: _controller.searchController),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Obx(() {
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
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            !_authenticationRepo.currentUser!.isAnonymous
                                ? Align(
                                    alignment: Alignment.topRight,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _controller.isNotified =
                                              !_controller.isNotified;
                                        });
                                        if (_controller.isNotified) {
                                          print("Notified");
                                        }
                                      },
                                      child: Icon(
                                        _controller.isNotified
                                            ? Icons.notifications_active
                                            : Icons.notifications_none,
                                        color: Colors.black,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(20),
                                      ),
                                    ),
                                  )
                                : Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(
                                      Icons.notifications_off,
                                      color: Colors.black,
                                    ),
                                  ),
                            SizedBox(width: 10),
                            !_authenticationRepo.currentUser!.isAnonymous
                                ? Align(
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
                                  )
                                : Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.black,
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
                        image:
                            NetworkImage(documentData['image_URL'].toString()),
                        width: 300,
                        height: 300,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Product description",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(documentData['desc'].toString()),
                    Container(
                      height: 300, // Set a fixed height for LineChartSample1
                      child: Center(
                        child: LineChartSample1(
                          dates: (documentData['dates'] as List<dynamic>)
                              .map((date) => (date as Timestamp).toDate())
                              .toList(),
                          prices: documentData['lowest_prices'],
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return Center(child: Text('Product not found.'));
              }
            }),
          ),
        ),
      ),
    );
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
