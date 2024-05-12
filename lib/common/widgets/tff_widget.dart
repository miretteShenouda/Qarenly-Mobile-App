import 'package:flutter/material.dart';

class TFF_widget extends StatelessWidget {
  const TFF_widget({
    Key? key,
    required this.Controller,
    required this.ticon,
    required this.hintText,
    this.validator,
    this.obscureText = false,
  }) : super(key: key);

  final TextEditingController Controller;
  final IconData ticon;
  final String hintText;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validator,
        controller: Controller,
        obscureText: obscureText,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(30, 10, 26, 10),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: Icon(ticon, color: Colors.orange.withOpacity(0.8)),
          hintText: hintText,
        ));
  }
}
