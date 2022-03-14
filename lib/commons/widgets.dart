import 'package:flutter/material.dart';

class FormFields {
  static Widget textField(String title, TextEditingController controller,
      {validator: null}) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          labelText: title,
          border: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 5))),
    );
  }

  static Widget passwordField(String title, TextEditingController controller,
      {validator: null}) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      validator: validator,
      decoration: InputDecoration(
          labelText: title,
          border: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 5))),
    );
  }

  static Widget textBox(String title, TextEditingController controller,
      {validator: null}) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          labelText: title,
          border: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 5))),
    );
  }
}

// showDialog(context: context, builder: (BuildContext context){
//     return AlertDialog(
//       title: Text("Success"),
//       content: Text("Saved successfully"),
//     );