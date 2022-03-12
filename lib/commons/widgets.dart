import 'package:flutter/material.dart';

class RegistrationFields extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final bool obscureText;

  const RegistrationFields(
      {Key? key,
      required this.controller,
      required this.title,
      this.obscureText: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: title,
          border: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 5))),
    );
  }
}
