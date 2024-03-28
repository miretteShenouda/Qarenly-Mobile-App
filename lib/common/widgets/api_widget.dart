import 'package:flutter/material.dart';
import 'package:qarenly/common/widgets/custom_elevated_button.dart';
import 'package:qarenly/common/widgets/custom_image_view.dart';
//import 'package:qarenly/core/utils/image_constant.dart';

class ApiButton extends StatelessWidget {
  const ApiButton({
    required this.text,
    required this.img,
    required this.onPressed, // Function parameter to handle onPressed event
    Key? key,
  }) : super(key: key);

  final String text;
  final String? img;
  final VoidCallback onPressed; // Define the type of function parameter

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.white,
      ),
      child: SizedBox(
        width: double.infinity,
        child: CustomElevatedButton(
          onPressed: onPressed, // Call the function passed from outside
          text: text,
          leftIcon: Container(
            margin: EdgeInsets.only(right: 20),
            child: CustomImageView(
              imagePath: img,
              width: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}
