import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donor/models/custom_user.dart';
import 'package:form_validator/form_validator.dart';
import 'package:food_donor/service/authentication_servcie.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // final _authService = AuthenictionService.instance;

  void _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String message = '';
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);
        _emailController.clear();
        _passwordController.clear();
        await Navigator.popAndPushNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password provided for that user.';
        }
      } finally {
        if (message.isNotEmpty) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
        }
      }
    }
  }

  void _register(BuildContext context) async {
    _emailController.clear();
    _passwordController.clear();
    await Navigator.of(context).pushNamed('/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _emailController,
                    validator: ValidationBuilder()
                        .email("Please enter a valid email")
                        .required("Please enter you email")
                        .build(),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    validator: ValidationBuilder()
                        .minLength(8, 'Password length invalid')
                        .required("Please enter your password")
                        .build(),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.key),
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: OutlinedButton.icon(
                      label: const Text(
                        "Login",
                        style: TextStyle(fontSize: 20),
                      ),
                      icon: const Icon(Icons.lock),
                      onPressed: () => _login(context),
                    ),
                  ),
                  TextButton(
                    child: const Text('Not yeat a user? Register here'),
                    onPressed: () => _register(context),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
