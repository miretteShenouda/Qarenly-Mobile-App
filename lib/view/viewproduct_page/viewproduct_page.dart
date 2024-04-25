import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qarenly/controller/viewProduct_controller.dart';

class ViewproductPage extends StatefulWidget {
  ViewproductPage({Key? key}) : super(key: key);

  @override
  _ViewProductPageState createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewproductPage> {
  late TextEditingController searchController;
  late ViewProductController _controller;
  late Future<DocumentSnapshot?> _documentFuture;
  String? _productId;
  String? _productType;

  @override
  void initState() {
    super.initState();
    _controller = ViewProductController();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      _productId = args['productId'] as String?;
      _productType = args['productType'] as String?;
    }
    _documentFuture = _initializeDocumentFuture();
  }

  Future<DocumentSnapshot?> _initializeDocumentFuture() async {
    print('productID: ${_productId} product Type: ${_productType} blaaaaabb');

    if (_productId != null && _productType != null) {
      print('productID: ${_productId} product Type: ${_productType} blaaaaa');
      final result =
          await _controller.getProductDetails(_productId!, _productType!);
      print("this is the result");
      print(result);
      if (result is DocumentSnapshot) {
        return result;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('View Product'),
        ),
        backgroundColor: Theme.of(context).colorScheme.onError,
        body: FutureBuilder<DocumentSnapshot?>(
          future: _documentFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data == null) {
              return Center(child: Text('Document not found.'));
            } else {
              print('object');
              print(snapshot.data);
              return Center(child: Text('Document found.'));
            }
          },
        ),
      ),
    );
  }
}


  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _productId = ModalRoute.of(context)?.settings.arguments as String?;
  //   _productFuture = _controller
  //       .getProductDetailsById(
  //         _productId ?? "",
  //         (productData) => Product.fromFirestore(productData),
  //       )
  //       .then((product) => product!);
  // }

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             appBar: BuildAppBar(searchController: searchController),
//             backgroundColor: Theme.of(context).colorScheme.onError,
//             body: FutureBuilder<DocumentSnapshot?>(
//                 future: _documentFuture,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else if (snapshot.data == null) {
//                     return Center(child: Text('Document not found.'));
//                   } else {
//                     // Document found, you can access its data here
//                     // For example:
//                     // final data = snapshot.data!.data();
//                     // print(data);
//                     return Center(child: Text('Document found.'));
//                   }
//                 })));
//   }

//   void printProductDetails(Product product) {
//     print('Product Name: ${product.name}');
//     print('product id:${product.id}');
//     // Add more properties to print as needed
//   }
// }
