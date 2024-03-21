import 'package:flutter/material.dart';
import 'package:qarenly/core/app_export.dart';

class SplashscreenScreen extends StatelessWidget {
  const SplashscreenScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimaryContainer,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 44.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 5.v),
              Container(
                width: 244.h,
                margin: EdgeInsets.only(left: 58.h),
                decoration: AppDecoration.outlineBlack,
                child: Text(
                  "Qarenly",
                  maxLines: null,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.displayMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
