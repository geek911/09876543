import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_donor/commons/fragments.dart';
import 'package:form_validator/form_validator.dart';

class ReceiverPage extends StatefulWidget {
  const ReceiverPage({Key? key}) : super(key: key);

  @override
  State<ReceiverPage> createState() => _ReceiverPageState();
}

class _ReceiverPageState extends State<ReceiverPage> {
  HomeFragmentType _fragmentType = HomeFragmentType.HOME;
  int _index = 0;

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
        child: Text('Received'),
      ),
      Center(
        child: Text('Profile'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: Icon(Icons.person)),
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
            icon: Icon(Icons.download),
            label: 'Receive',
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
        child: Icon(Icons.add),
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
