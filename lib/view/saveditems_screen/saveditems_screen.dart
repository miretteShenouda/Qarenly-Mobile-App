import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qarenly/common/widgets/app_bar/app_bar.dart';
import 'package:qarenly/common/widgets/productcard_item_widget.dart';
import 'package:qarenly/controller/savedItems_controller.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/repository/authentication%20repository/authentication_repo.dart';

class SaveditemsScreen extends StatefulWidget {
  SaveditemsScreen({Key? key}) : super(key: key);

  @override
  _SaveditemsScreenState createState() => _SaveditemsScreenState();
}

class _SaveditemsScreenState extends State<SaveditemsScreen> {
  bool value = false; // Initial value for the checkbox
  TextEditingController searchController = TextEditingController();
  final savedItemsController = Get.put(SavedItemsController());

  final _authenticationRepo = Get.put(AuthenticationRepo());

  void initState() {
    savedItemsController.fetchSavedItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: BuildAppBar(
            searchController: searchController,
            authenticationRepo: _authenticationRepo,
          ),
          body: Obx(() {
            if (savedItemsController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              return SingleChildScrollView(
                child: Container(
                  width: 391.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.v),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 14.0),
                      _buildSavedItemsSection(context),
                      SizedBox(height: 7.0),
                    ],
                  ),
                ),
              );
            }
          })),
    );
  }

  Widget _buildSavedItemsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Saved Items',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 7),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(height: 7.0);
          },
          itemCount: savedItemsController.savedItemsProducts.length,
          itemBuilder: (context, index) {
            return ProductcardItemWidget(
              product: savedItemsController.savedItemsProducts[index],
              savedItemsController: savedItemsController,
            );
          },
        ),
      ],
    );
  }
}
