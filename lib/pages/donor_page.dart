import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_donor/commons/fragments.dart';
import 'package:food_donor/commons/widgets.dart';
import 'package:food_donor/database.dart';
import 'package:food_donor/models/custom_user.dart';
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

  List<Widget> get _dashboardWidgets {
    return [
      Center(
        child: Text('Listings'),
      ),
      Center(
        child: Text('Donated'),
      ),
      ProfileWidget.profileBody(context, _user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: _dashboardWidgets[_index],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Listings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Donate',
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
