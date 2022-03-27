import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_donor/commons/fragments.dart';
import 'package:food_donor/commons/widgets.dart';
import 'package:food_donor/database.dart';
import 'package:food_donor/models/custom_user.dart';
import 'package:form_validator/form_validator.dart';

import '../repositories/donations_repository.dart';

class ReceiverPage extends StatefulWidget {
  const ReceiverPage({Key? key}) : super(key: key);

  @override
  State<ReceiverPage> createState() => _ReceiverPageState();
}

class _ReceiverPageState extends State<ReceiverPage> {
  HomeFragmentType _fragmentType = HomeFragmentType.HOME;
  int _index = 0;
  CustomUser _user = CustomUser();
  var _title = ['All Donations', 'Received Donations', 'Profile'];

  List<Donation> _donations = [];

  Future<CustomUser> _loadProfile() async {
    var user = await Database.getProfile();

    return user;
  }

  @override
  void initState() {
    _loadProfile().then((value) {
      setState(() {});
      _user = value;
    });

    _loadAllDonations();

    super.initState();
  }

  void _changeFragment(int index) {
    setState(() {
      _index = index;
    });

    _loadAllDonations();
  }

  void _loadAllDonations() {
    if (_index == 0) {
      Database.getAllDonations().then((value) {
        setState(() {});

        _donations = value;
      });
    }
  }

  Widget _dashboardWidgets(BuildContext context, int index) {
    var widgetList = [
      ListViewFactory.listingsListView(context, _donations),
      Center(
        child: Text('Received'),
      ),
      Center(
        child: Text('Donated'),
      ),
    ];

    return widgetList[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title[_index]),
        centerTitle: true,
        actions: [
          // IconButton(
          //     onPressed: () {
          //       Navigator.pushNamed(context, '/profile');
          //     },
          //     icon: Icon(Icons.person)),
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await Navigator.pushReplacementNamed(context, '/default');
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: _dashboardWidgets(context, _index),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Listings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download),
            label: 'Received',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _index,
        onTap: _changeFragment,
      ),
    );
  }

  _showAddDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Donation',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      validator: ValidationBuilder()
                          .minLength(5, 'Title too short')
                          .required("Please enter title")
                          .build(),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.add),
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      // minLines: 2,
                      // maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      validator: ValidationBuilder()
                          .required("Please enter description")
                          .build(),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.add),
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
