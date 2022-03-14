import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donor/commons/widgets.dart';
import 'package:food_donor/service/authentication_servcie.dart';

import 'package:food_donor/models/custom_user.dart';
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
  bool isDonator = false;

  Future<void> _register(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Create person pojo

      String message = '';

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text);
        await userCredential.user?.updateDisplayName(
            "${firstnameController.text.trim()} ${lastnameController.text.trim()}");
        Navigator.of(context).pop();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          message = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          message = 'The account already exists for that email.';
        }
      } catch (e) {
        message = 'Something went wrong, please check your net connectivity';
      } finally {
        if (message.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        }
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
              FormFields.passwordField(
                  "Comfirm Password", confirmPasswordController,
                  validator: (String? value) {
                if (value == null) {
                  return "This field is required";
                } else if (value != passwordController.text) {
                  return "Passwords are not the same";
                } else {
                  return null;
                }
              }),
              const SizedBox(
                height: 10,
              ),
              Checkbox(
                  value: isDonator,
                  onChanged: (value) {
                    isDonator = !isDonator;
                  }),
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
