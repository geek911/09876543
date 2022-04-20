import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donor/commons/widgets.dart';
import 'package:food_donor/models/receiver.dart';
import 'package:food_donor/service/authentication_servcie.dart';

import 'package:food_donor/models/custom_user.dart';
import 'package:form_validator/form_validator.dart';
import 'package:food_donor/database.dart';

class ReceiverRegisterPage extends StatefulWidget {
  ReceiverRegisterPage({Key? key}) : super(key: key);

  @override
  State<ReceiverRegisterPage> createState() => _ReceiverRegisterPageState();
}

class _ReceiverRegisterPageState extends State<ReceiverRegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final organisationController = TextEditingController();

  final phoneNumberController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();
  final descriptionController = TextEditingController();

  bool isDonator = false;

  Future<void> _register(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Create person pojo

      String message = '';

      try {
        var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text);

        user.user?.updateDisplayName(organisationController.text);

        var receiver = Receiver();

        receiver.id = user.user?.uid;
        receiver.donator = isDonator;
        receiver.description = descriptionController.text;
        receiver.phoneNumber = phoneNumberController.text;
        receiver.email = emailController.text.trim();

        await Database.addProfile(receiver.toProfileJson()).then((value) {
          Navigator.of(context).pop();
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          message = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          message = 'The account already exists for that email.';
        }
      } catch (e) {
        message =
            'Something went wrong, please check your network connectivity';
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
              FormFields.textField("Organisation Name", organisationController,
                  validator: ValidationBuilder()
                      .minLength(2)
                      .maxLength(20)
                      .required("Organisation cannot be empty")
                      .build()),
              const SizedBox(
                height: 10,
              ),
              FormFields.textBox(
                "Organisation Description",
                descriptionController,
              ),
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
              FormFields.textField('Phone Number', phoneNumberController,
                  validator: ValidationBuilder()
                      .phone("Please enter phone number")
                      .required("Phone cannot be empty")
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
                  "Confirm Password", confirmPasswordController,
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
