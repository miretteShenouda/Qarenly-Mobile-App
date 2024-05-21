import 'package:flutter/material.dart';
import 'package:qarenly/core/app_export.dart';

// ignore: must_be_immutable
class AppbarTitleImage extends StatelessWidget {
  AppbarTitleImage({
    Key? key,
    this.imagePath,
    this.margin,
    this.onTap,
    this.height = 53,
    this.width = 53,
  }) : super(
          key: key,
        );

  String? imagePath;
  double? height;
  EdgeInsetsGeometry? margin;
  double? width;
  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // onTap!.call();
          if (onTap != null) onTap!();
        },
        child: Padding(
          padding: margin ?? EdgeInsets.zero,
          child: CustomImageView(
            imagePath: imagePath,
            height: height?.adaptSize,
            width: width?.adaptSize,
            fit: BoxFit.contain,
          ),
        ));
  }
}
