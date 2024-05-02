import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({
    required this.buttonIcon,
    required this.title,
    required this.subTitle,
    required this.ontap,
    Key? key,
  }) : super(key: key);

  final IconData buttonIcon;
  final String title, subTitle;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.orange[100]),
        child: Row(
          children: [
            Icon(buttonIcon, size: 50),
            SizedBox(width: 20),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: Theme.of(context).textTheme.headlineSmall),
              Text(subTitle, style: Theme.of(context).textTheme.bodyMedium),
            ])
          ],
        ),
      ),
    );
  }
}
