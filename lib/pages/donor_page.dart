import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_donor/commons/fragments.dart';
import 'package:food_donor/commons/widgets.dart';
import 'package:food_donor/database.dart';
import 'package:food_donor/models/custom_user.dart';
import 'package:food_donor/repositories/donations_repository.dart';
import 'package:form_validator/form_validator.dart';

class DonorPage extends StatefulWidget {
  const DonorPage({Key? key}) : super(key: key);

  @override
  State<DonorPage> createState() => _DonorPageState();
}

class _DonorPageState extends State<DonorPage> {
  HomeFragmentType _fragmentType = HomeFragmentType.HOME;
  int _index = 0;

  CustomUser _user = CustomUser();

  List<Donation> _donations = [];

  var _title = ['All Donations', 'My Donations', 'Profile'];

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

    super.initState();
  }

  void _changeFragment(int index) {
    setState(() {
      _index = index;
    });
  }

  void _loadAllDonations() {
    if (_index == 0) {
      Database.getAllDonations().then((value) {
        setState(() {
          _donations = value;
        });
      });
    } else if (_index == 1) {
      Database.getMyDonations().then((value) {
        setState(() {
          _donations = value;
        });
      });
    }
  }

  Widget _dashboardWidgets(BuildContext context, int index) {
    var widgetList = [
      ListViewFactory.listingsListView(context, _donations),
      ListViewFactory.donorListingsListView(context, _donations),
      ProfileWidget.profileBody(context, _user)
    ];

    return widgetList[index];
  }

  @override
  Widget build(BuildContext context) {
    _loadAllDonations();

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
            icon: Icon(Icons.upload),
            label: 'Donated',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _index,
        onTap: _changeFragment,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed('/add_donation');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
