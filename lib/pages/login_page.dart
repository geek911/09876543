import 'package:flutter/material.dart';
import 'package:food_donor/models/user.dart';
import 'package:form_validator/form_validator.dart';
import 'package:food_donor/service/authentication_servcie.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthenictionService.instance;

  void _login(BuildContext context) async {
    await Navigator.popAndPushNamed(context, '/home');
  }

  // void _login(BuildContext context) async {
  //   if (_formKey.currentState!.validate()) {
  //     var user = User();

  //     user.email = _emailController.text;
  //     user.password = _passwordController.text;

  //     var result = _authService.login(user);
  //     if (result) {
  //       await Navigator.popAndPushNamed(context, '/home');
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //           content: Text(
  //               'Something is not right, please check your internet connection')));
  //     }
  //   }
  // }

  void _register(BuildContext context) async {
    await Navigator.of(context).pushNamed('/register');
  }

  void dispose() {}

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
