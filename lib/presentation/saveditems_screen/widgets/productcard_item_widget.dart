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
      decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder20,
      ),
      child: Stack(
        children: [
          Row(
            children: [
              CustomImageView(
                imagePath: ImageConstant.img164691852916392,
                height: 128.v,
                width: 104.h,
                radius: BorderRadius.circular(
                  20.h,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 11.h,
                  top: 15.v,
                  bottom: 3.v,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 115.h,
                      child: Text(
                        "lenovo gxz45\nSource: Amazon",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 48.v),
                    Align(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "30700",
                              style: theme.textTheme.titleSmall!.copyWith(
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            TextSpan(
                              text: " LE 35999",
                              style: theme.textTheme.titleSmall,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                // Handle the tap on the trash icon here
                print('Trash icon tapped!');
              },
              child: CustomImageView(
                imagePath: ImageConstant.imgOcticonTrash16,
                height: 25.adaptSize,
                width: 25.adaptSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
