import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_donor/database.dart';
import 'package:food_donor/models/custom_user.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var _user = FirebaseAuth.instance.currentUser;
  CustomUser customUser = CustomUser();

  @override
  void initState() {
    _getProfile().then((value) {
      setState(() {
        customUser = value;
      });
    });
  }

  // final AuthenictionService _authenictionService = AuthenictionService.instance;
  Future<CustomUser> _getProfile() async {
    var user = await Database.getProfile();
    return user;
  }

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
              customUser.phoneNumber ??= 'Loading',
              style: TextStyle(fontSize: 20),
            ),
            Text("Description"),
            SizedBox(
              height: 8,
            ),
            Text(
              customUser.description ??= 'Loading',
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
