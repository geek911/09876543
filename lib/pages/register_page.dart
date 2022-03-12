import 'package:flutter/material.dart';
import 'package:food_donor/commons/widgets.dart';
import 'package:food_donor/service/authentication_servcie.dart';

import 'package:food_donor/models/user.dart';
import 'package:form_validator/form_validator.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final AuthenictionService _authenictionService = AuthenictionService.instance;

  void _register(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Create person pojo
      var user = User();
      user.displayName =
          '${firstnameController.text} ${lastnameController.text}';
      user.phoneNumber = phoneNumberController.text;
      user.email = emailController.text;
      user.password = passwordController.text;

      var successful = _authenictionService.register(user);
      if (successful) {
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Something is not right, please check your internet connection')),
        );
      }
    }
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              FormFields.textField("Firstname", firstnameController,
                  validator: ValidationBuilder()
                      .minLength(2)
                      .maxLength(20)
                      .required("Firstname cannot be empty")
                      .build()),
              const SizedBox(
                height: 10,
              ),
              FormFields.textField("Lastname", lastnameController,
                  validator: ValidationBuilder()
                      .minLength(2)
                      .maxLength(20)
                      .required("Lastname cannot be empty")
                      .build()),
              const SizedBox(
                height: 10,
              ),
              FormFields.textField('Email', emailController,
                  validator: ValidationBuilder()
                      .email("Please enter a valid email")
                      .required("Email cannot be empty")
                      .build()),
              const SizedBox(
                height: 10,
              ),
              FormFields.passwordField("Password", passwordController,
                  validator: ValidationBuilder()
                      .minLength(
                          8, 'Password should be a minimum of 8 characters')
                      .required("Password Cannot be empty")
                      .build()),
              const SizedBox(
                height: 10,
              ),
              FormFields.passwordField("Comfirm Password", passwordController,
                  validator: ValidationBuilder()
                      .minLength(
                          8, 'Password should be a minimum of 8 characters')
                      .required("Password Cannot be empty")
                      .build()),
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
      ),
    );
  }
}
