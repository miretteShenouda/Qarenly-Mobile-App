// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:qarenly/common/widgets/app_bar/app_bar.dart';
import 'package:qarenly/controller/viewProduct_controller.dart';
import 'package:get/get.dart';

class ViewproductPage extends StatefulWidget {
  ViewproductPage({Key? key}) : super(key: key);
  final controller = Get.put(ViewProductController());

  @override
  _ViewProductPageState createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewproductPage> {
  late ViewProductController _controller = Get.put(ViewProductController());

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
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Product Name:\n" + documentData['name'].toString(),
                          maxLines: 2,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.android_rounded,
                            color: Colors.black,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                          )),
                      ElevatedButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.android_rounded,
                            color: Colors.black,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image(
                    image: NetworkImage(documentData['image_URL'].toString()),
                    width: 300,
                    height: 300,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Flexible(
                      child: Text("Product Description:\n" +
                          documentData['desc'].toString())),
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