import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donor/database.dart';
import 'package:food_donor/models/custom_user.dart';
import 'package:food_donor/pages/donor_page.dart';
import 'package:food_donor/pages/home_page.dart';
import 'package:food_donor/pages/receive_page.dart';
import 'package:form_validator/form_validator.dart';
import 'package:food_donor/service/authentication_servcie.dart';

class FutureNavigation extends StatefulWidget {
  const FutureNavigation({Key? key}) : super(key: key);

  @override
  _FutureNavigationState createState() => _FutureNavigationState();
}

class _FutureNavigationState extends State<FutureNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return FutureBuilder(
        future: _login(),
        builder: (context, snapshot) {
          return Center(child: CircularProgressIndicator());
        },
      );
    } else {
      return FutureBuilder(
        future: _dashboard(),
        builder: (context, snapshot) {
          return Center(child: CircularProgressIndicator());
        },
      );
    }
  }

  Future<void> _login() async {
    await Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return LoginPage();
          },
        ),
      );
    });
  }

  Future<void> _dashboard() async {
    var profile = await Database.getProfile();

    bool isDonator = profile.donator ??= false;

    if (isDonator) {
      await Future.delayed(Duration(seconds: 3));
      await Navigator.pushReplacementNamed(context, '/donor_page');
    } else {
      await Future.delayed(Duration(seconds: 3));
      await Navigator.pushReplacementNamed(context, '/receiver_page');
    }
  }
}

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
                email: _emailController.text.trim(),
                password: _passwordController.text);
        _emailController.clear();
        _passwordController.clear();
        await Navigator.pushReplacementNamed(context, '/default');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password provided for that user.';
        } else {
          message = e.message.toString();
        }
      } finally {
        if (message.isNotEmpty) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
        }
      }
    }
  }

  void _registerDonor(BuildContext context) async {
    _emailController.clear();
    _passwordController.clear();
    await Navigator.of(context).pushNamed('/register');
  }

  void _registerReciever(BuildContext context) async {
    _emailController.clear();
    _passwordController.clear();
    await Navigator.of(context).pushNamed('/register_receiver');
  }

  // Widget _checkStatus(){
  //   if(FirebaseAuth.instance.currentUser == null){}
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      'assets/icon.png',
                    ),
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
                      child: const Text('Not yet a donor? Register here'),
                      onPressed: () => _registerDonor(context),
                    ),
                    TextButton(
                      child: const Text(
                          'Want to Receive donations? Register here'),
                      onPressed: () => _registerReciever(context),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
