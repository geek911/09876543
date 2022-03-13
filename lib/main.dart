import 'package:flutter/material.dart';
import 'package:food_donor/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_donor/firebase_options.dart';

// Import the firebase_app_check plugin
import 'package:firebase_app_check/firebase_app_check.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  runApp(App());
}
