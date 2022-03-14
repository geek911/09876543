import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  var _user = FirebaseAuth.instance.currentUser;

  // final AuthenictionService _authenictionService = AuthenictionService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Text('Full Name'),
            SizedBox(
              height: 8,
            ),
            Text(
              _user?.displayName != null
                  ? _user?.displayName as String
                  : "Not Added",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 8,
            ),
            Text("Email"),
            SizedBox(
              height: 8,
            ),
            Text(
              _user?.email as String,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 8,
            ),
            Text("Phone Number"),
            SizedBox(
              height: 8,
            ),
            Text(
              _user?.phoneNumber != null
                  ? _user?.phoneNumber as String
                  : 'Not Added',
              style: TextStyle(fontSize: 20),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              margin: EdgeInsets.only(top: 19, left: 10),
              child: SizedBox(
                height: 1,
                width: 100,
              ),
            )
          ],
        ),
      ),
    );
  }
}
