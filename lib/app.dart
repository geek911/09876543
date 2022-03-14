import 'package:flutter/material.dart';
import 'package:food_donor/pages/add_donation_page.dart';
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
        '/default': (context) => FutureNavigation(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/profile': (context) => ProfilePage(),
        '/home': (context) => HomePage(),
        '/add_donation': (context) => AddDonationPage()
      },
      initialRoute: '/default',
    );
  }
}
