import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_donor/app.dart';
import 'package:flutter/widgets.dart';
import 'package:food_donor/commons/widgets.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void _register(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            RegistrationFields(
              controller: firstnameController,
              title: "Firstname",
            ),
            const SizedBox(
              height: 10,
            ),
            RegistrationFields(
              controller: lastnameController,
              title: "Lastname",
            ),
            const SizedBox(
              height: 10,
            ),
            RegistrationFields(
              controller: emailController,
              title: "Email",
            ),
            RegistrationFields(
              controller: passwordController,
              title: "Password",
            ),
            const SizedBox(
              height: 10,
            ),
            RegistrationFields(
              controller: confirmPasswordController,
              title: "Confirm Password ",
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: OutlinedButton.icon(
                label: const Text(
                  "Register",
                  style: TextStyle(fontSize: 20),
                ),
                icon: const Icon(Icons.app_registration),
                onPressed: () => _register(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
