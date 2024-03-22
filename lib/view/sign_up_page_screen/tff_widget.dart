import 'package:flutter/material.dart';

class TFF_widget extends StatelessWidget {
  const TFF_widget({
    Key? key,
    required this.userNameController,
    required this.ticon,
    required this.labelText,
  }) : super(key: key);

  final TextEditingController userNameController;
  final IconData ticon;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.white,
      ),
      child: TextFormField(
          controller: userNameController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(ticon, color: Colors.orange.withOpacity(0.8)),
            labelText: labelText,
          )),
    );
  }
}
