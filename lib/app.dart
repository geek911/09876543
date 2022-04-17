import 'package:flutter/material.dart';
import 'package:food_donor/pages/accept_request.dart';
import 'package:food_donor/pages/add_donation_page.dart';
import 'package:food_donor/pages/login_page.dart';
import 'package:food_donor/pages/donor_register_page.dart';
import 'package:food_donor/pages/profile_page.dart';
import 'package:food_donor/pages/home_page.dart';
import 'package:food_donor/pages/donor_page.dart';
import 'package:food_donor/pages/receiver_register_page.dart';
import 'package:food_donor/pages/receive_page.dart';
import 'package:food_donor/pages/donor_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/default': (context) => FutureNavigation(),
        '/login': (context) => LoginPage(),
        '/register': (context) => DonorRegisterPage(),
        '/register_receiver': (context) => ReceiverRegisterPage(),
        '/profile': (context) => ProfilePage(),
        '/home': (context) => HomePage(),
        '/add_donation': (context) => AddDonationPage(),
        '/donor': (context) => DonorPage(),
        '/receiver_page': (context) => ReceiverPage(),
        '/donor_page': (context) => DonorPage(),
        '/accept': (context) => AcceptRequest()
      },
      initialRoute: '/default',
    );
  }
}
