import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppbarTitleSearchview extends StatelessWidget {
  AppbarTitleSearchview({
    Key? key,
    this.hintText,
    this.controller,
    this.margin,
  }) : super(
          key: key,
        );

  String? hintText;

  TextEditingController? controller;

  EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        color: Colors.white,
        border: Border.all(
          color: Color.fromARGB(
              255, 0, 48, 73), // Set the color of the border to blue
          width: 2.0,
        ),
        // Adjust the radius as needed
      ),
      child: Center(
        child: TextField(
            decoration: InputDecoration(
          hintText: 'Search for something',
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Color.fromARGB(255, 0, 48, 73),
          ),
        )),
      ),
    );
    //  Padding(
    //   padding: margin ?? EdgeInsets.zero,
    //   child: CustomSearchView(
    //     width: 240.h,
    //     controller: controller,
    //     hintText: "Search..",
    //   ),
    // );
  }
}
