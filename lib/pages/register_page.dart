import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donor/commons/widgets.dart';
import 'package:food_donor/service/authentication_servcie.dart';

import 'package:food_donor/models/custom_user.dart';
import 'package:form_validator/form_validator.dart';
import 'package:food_donor/database.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final firstnameController = TextEditingController();

  final lastnameController = TextEditingController();

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

        user.user?.updateDisplayName(
            "${firstnameController.text.trim()} ${lastnameController.text.trim()}");

        var customUser = CustomUser();

        customUser.id = user.user?.uid;
        customUser.firstName = firstnameController.text;
        customUser.lastName = lastnameController.text;
        customUser.donator = isDonator;
        customUser.description = descriptionController.text;
        customUser.phoneNumber = phoneNumberController.text;

        await Database.addProfile(customUser.toProfileJson()).then((value) {
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
              FormFields.textBox(
                "Description",
                descriptionController,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Donor?"),
                  Checkbox(
                      value: isDonator,
                      onChanged: (value) {
                        setState(() {
                          isDonator = !isDonator;
                        });
                      }),
                ],
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
      ),
    );
  }
}
