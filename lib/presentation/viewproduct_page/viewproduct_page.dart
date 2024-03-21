import 'package:flutter/material.dart';
import 'package:qarenly/controller/viewProduct_controller.dart';

import 'package:qarenly/core/app_export.dart';
// import '../../common/widgets/app_bar/appbar_title_searchview.dart';
import '../../common/widgets/app_bar/app_bar.dart';
import '../../model/product_model.dart';

// ignore_for_file: must_be_immutable
class ViewproductPage extends StatefulWidget {
  ViewproductPage({
    Key? key,
  }) : super(key: key);
  @override
  _ViewProductPageState createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewproductPage> {
  late TextEditingController searchController;
  late ViewProductController _controller;
  late Future<Product> _productFuture;

  @override
  void initState() {
    super.initState();
    _controller = ViewProductController();
    searchController = TextEditingController();
    // _productFuture = _controller.getProductDetails("0DU6lYGAniKzHLyVgdp2",
    //(productData) => Product.fromFirestore(productData)) as Future<Product>;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: BuildAppBar(searchController: searchController),
            backgroundColor: Theme.of(context).colorScheme.onError,
            body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 15.v),
                  child: Padding(
                      padding: EdgeInsets.only(right: 3.h),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // _buildProductDetails(context),
                          ])),
                ))));
  }

  // PreferredSizeWidget _buildAppBar(BuildContext context) {
  //   return CustomAppBar(
  //     leadingWidth: 69.h,
  //     leading: Row(
  //       children: [
  //         AppbarLeadingImage(
  //           imagePath: ImageConstant.imgEiUser,
  //           margin: EdgeInsets.only(left: 16.h, top: 7.v, bottom: 1.v),
  //         ),
  //       ],
  //     ),
  //     centerTitle: false,
  //     title: Container(
  //       margin: EdgeInsets.only(left: 5.h, top: 10.v, bottom: 1.v),
  //       child: Expanded(
  //         child: AppbarTitleSearchview(
  //           hintText: "search",
  //           controller: searchController,
  //         ),
  //       ),
  //     ),
  //     actions: [
  //       AppbarTrailingImage(
  //         imagePath: ImageConstant.imgBasilMenuOutline,
  //         margin: EdgeInsets.fromLTRB(6.h, 8.v, 15.h, 1.v),
  //         onTap: () {
  //           onTapBasilMenuOutline(context);
  //         },
  //       ),
  //     ],
  //   );
  // }

  // onTapBasilMenuOutline(BuildContext context) {
  //   Navigator.pushNamed(context, AppRoutes.sideMenuScreen);
  // }
// Widget _buildProductDetails(Product product)
// {
//   // return Column(
//   //   crossAxisAlignment: CrossAxisAlignment.start,
//   //   children: [Text()],
//   // )
// }
}
