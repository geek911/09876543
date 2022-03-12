import 'package:flutter/material.dart';
import 'package:food_donor/commons/fragments.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        child: Text('Donated'),
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
              onPressed: () {
                // Navigator.push(context, '/home');
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
            label: 'Received',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Donated',
          ),
        ],
        currentIndex: _index,
        onTap: _changeFragment,
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }
}
