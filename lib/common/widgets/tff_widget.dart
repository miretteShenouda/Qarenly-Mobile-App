import 'package:flutter/material.dart';

class TFF_widget extends StatelessWidget {
  const TFF_widget({
    Key? key,
    required this.Controller,
    required this.ticon,
    required this.hintText,
    this.validator,
  }) : super(key: key);

  final TextEditingController Controller;
  final IconData ticon;
  final String hintText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.white,
      ),
      child: TextFormField(
          validator: validator,
          controller: Controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(ticon, color: Colors.orange.withOpacity(0.8)),
            hintText: hintText,
          )),
    );
  }
}
