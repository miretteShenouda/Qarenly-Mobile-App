// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:qarenly/common/widgets/app_bar/app_bar.dart';
import 'package:qarenly/controller/viewProduct_controller.dart';
import 'package:get/get.dart';

import '../../common/theme/app_decoration.dart';

class ViewproductPage extends StatefulWidget {
  ViewproductPage({Key? key}) : super(key: key);
  final controller = Get.put(ViewProductController());

  @override
  _ViewProductPageState createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewproductPage> {
  late ViewProductController _controller = Get.put(ViewProductController());
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


  // void _scrollNext() {
  //   setState(() {
  //     _currentIndex = (_currentIndex + 1) % _controller.documentData.value?['sources'] ;
  //   });
  //
  //   if (!_scrollController.hasClients) return;
  //
  //   //final maxScroll = _scrollController.position.maxScrollExtent;
  //   final itemWidth = MediaQuery.of(context).size.width;
  //   final targetScroll = _currentIndex * itemWidth;
  //
  //   _scrollController.animateTo(
  //     targetScroll,
  //     duration: const Duration(milliseconds: 500),
  //     curve: Curves.easeInOut,
  //   );
  // }



//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         child: Scaffold(
//             appBar: BuildAppBar(searchController: _controller.searchController),
//             body: Column(children: [
//               Row(children: [
//                 Text("Product Name:\n" +
//                     _controller.documentData!['name'].toString()),
//               ])
//             ])),
//       ),
//     );
//   }
// }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BuildAppBar(searchController: _controller.searchController),
        body: Padding(
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
                          Align(
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
                          ),
                          SizedBox(width: 10),
                          Align(
                            alignment: Alignment.topRight,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _controller.isSaved = !_controller.isSaved;
                                });
                                if (_controller.isSaved) {
                                  print('Added to saved items');
                                } else {
                                  print('Removed from saved items');
                                }
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
                  child :Image(
                    image: NetworkImage(documentData['image_URL'].toString()),
                    width: 300,
                    height: 300,
                  ),),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Product Name",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Flexible(child: Text(documentData['desc'].toString())),
                ],
              );
            } else {
              return Center(child: Text('Product not found.'));
            }
          }),
        ),
      ),
    );
  }



  void _scrollNext() {
    if (_controller.documentData.value == null) return;

    setState(() {
      // _currentIndex = (_currentIndex + 1) % _controller.documentData.value!['sources']!.length;
    });

    if (!_scrollController.hasClients) return;

    final itemWidth = MediaQuery.of(context).size.width;
    final targetScroll = _currentIndex * itemWidth;

    _scrollController.animateTo(
      targetScroll,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
  Widget _buildHorizontalScrollingSection() {
    return Container(
      decoration: AppDecoration.fillPrimary,
      height: 198.0,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: _controller.documentData.value?['sources'].length,
        itemBuilder: (context, index) {
          // final imageUrl = controller.laptops[index].imageUrl;
          return Container(
            margin: EdgeInsets.symmetric(
                horizontal: 5.0), // Add margin for spacing between items



          );
        },
      ),
    );
  }

}
//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

// @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('View Product'),
//         ),
//         backgroundColor: Theme.of(context).colorScheme.onError,
//         body: FutureBuilder<DocumentSnapshot?>(
//           future: _controller.documentFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else if (snapshot.data == null) {
//               return Center(child: Text('Document not found.'));
//             } else {
//               print('object');
//               print(snapshot.data);
//               return Center(child: Text('Document found.'));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
