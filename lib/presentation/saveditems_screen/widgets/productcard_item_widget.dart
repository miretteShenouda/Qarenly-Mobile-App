import 'package:flutter/material.dart';
import 'package:qarenly/core/app_export.dart';

// ignore: must_be_immutable
class ProductcardItemWidget extends StatelessWidget {
  const ProductcardItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 18.h,
        vertical: 9.v,
      ),
      decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 1.v),
          Padding(
            padding: EdgeInsets.only(left: 81.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: 203.h,
                    margin: EdgeInsets.only(top: 6.v),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "Pre-Owned Apple iPhone 13 128GB Blue (Unlocked) (Refurbished: Good)\n",
                            style: CustomTextStyles.titleSmallMedium.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(
                            text: "\n",
                            style: CustomTextStyles.titleSmallMedium,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgOcticonTrash16,
                  height: 25.adaptSize,
                  width: 25.adaptSize,
                  margin: EdgeInsets.only(
                    left: 8.h,
                    bottom: 40.v,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 3.v),
          Padding(
            padding: EdgeInsets.only(right: 9.h),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "659.00",
                    style: theme.textTheme.titleSmall!.copyWith(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  TextSpan(
                    text: " 494.00",
                    style: theme.textTheme.titleSmall,
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
