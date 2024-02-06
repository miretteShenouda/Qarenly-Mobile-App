import '../viewproduct_page/widgets/productcardlist_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:qarenly/core/app_export.dart';

// ignore_for_file: must_be_immutable
class ViewproductPage extends StatefulWidget {
  const ViewproductPage({Key? key})
      : super(
          key: key,
        );

  @override
  ViewproductPageState createState() => ViewproductPageState();
}

class ViewproductPageState extends State<ViewproductPage>
    with AutomaticKeepAliveClientMixin<ViewproductPage> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillOnSecondaryContainer1,
          child: Column(
            children: [
              SizedBox(height: 38.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 11.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 368.h,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "\n\nDell Inspiron 14 7430 2-in-1 Laptop,\n 13th Generation Intel Core i7-1355U, \n14\"\n 16:10 FHD+ Touchscreen, \n16GB RAM, 512GB SSD,\n Backlit Keyboard, Fingerprint \nReader,\nBrand:Dell\nModel name: Inspiron 14 2-in-1\nLaptopScreen size: 14 Inches\nColourPlatinum: Silver\nCPU model: Core i7 Family\nRAM memory installed size: 16 GB \n\n",
                              style: CustomTextStyles.titleLargeff003049,
                            ),
                            TextSpan(
                              text: "\n",
                              style:
                                  CustomTextStyles.titleLargeff003049.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 59.v),
                    _buildProductCardList(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildProductCardList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 9.h,
        right: 26.h,
      ),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (
          context,
          index,
        ) {
          return SizedBox(
            height: 20.v,
          );
        },
        itemCount: 2,
        itemBuilder: (context, index) {
          return ProductcardlistItemWidget();
        },
      ),
    );
  }
}
