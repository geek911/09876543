import 'package:flutter/material.dart';
import 'package:food_donor/pages/login_page.dart';
import 'package:food_donor/pages/register_page.dart';
import 'package:food_donor/pages/profile_page.dart';
import 'package:food_donor/pages/home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/profile': (context) => ProfilePage(),
        '/home': (context) => HomePage(),
      },
      initialRoute: '/login',
    );
  }
}
