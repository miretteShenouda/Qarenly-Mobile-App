import 'package:flutter/material.dart';
import 'package:qarenly/core/app_export.dart';
import 'package:qarenly/common/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class ProductcardlistItemWidget extends StatelessWidget {
  const ProductcardlistItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 18.v,
            bottom: 21.v,
          ),
          child: CustomIconButton(
            height: 50.adaptSize,
            width: 50.adaptSize,
            padding: EdgeInsets.all(3.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgIcomoonFreeAmazon,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20.h),
          padding: EdgeInsets.symmetric(
            horizontal: 52.h,
            vertical: 17.v,
          ),
          decoration: AppDecoration.fillOnPrimaryContainer,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 4.v),
              Container(
                width: 151.h,
                margin: EdgeInsets.only(right: 3.h),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "669.00",
                        style: CustomTextStyles.bodyLargeff003049.copyWith(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      TextSpan(
                        text: " 483.00 \n(27% off)\n",
                        style: CustomTextStyles.bodyLargeff003049,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
