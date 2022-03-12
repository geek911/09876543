import 'package:flutter/material.dart';
import 'package:food_donor/commons/fragments.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeFragmentType _fragmentType = HomeFragmentType.HOME;

  void _changeFragment(HomeFragmentType type, BuildContext context) {
    Navigator.of(context).pop();
    setState(() {
      _fragmentType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: HomeFragments.newWidget(_fragmentType),
      drawer: Drawer(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 70,
                  ),
                )
              ],
            ),
            ListTile(
              title: const Text("Home"),
              onTap: () => _changeFragment(HomeFragmentType.HOME, context),
            ),
            ListTile(
              title: const Text("Donations"),
              onTap: () => _changeFragment(HomeFragmentType.DONATIONS, context),
            ),
            ListTile(
              title: const Text("Received"),
              onTap: () => _changeFragment(HomeFragmentType.RECEIVED, context),
            ),
            ListTile(
              title: const Text("Profile"),
              onTap: () => _changeFragment(HomeFragmentType.PROFILE, context),
            )
          ],
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }
}
