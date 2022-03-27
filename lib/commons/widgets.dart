import 'package:flutter/material.dart';
import 'package:food_donor/database.dart';
import 'package:food_donor/models/custom_user.dart';

import '../repositories/donations_repository.dart';

class FormFields {
  static Widget textField(String title, TextEditingController controller,
      {validator: null}) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          labelText: title,
          border: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 5))),
    );
  }

  static Widget passwordField(String title, TextEditingController controller,
      {validator: null}) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      validator: validator,
      decoration: InputDecoration(
          labelText: title,
          border: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 5))),
    );
  }

  static Widget textBox(String title, TextEditingController controller,
      {validator: null}) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          labelText: title,
          border: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 5))),
    );
  }
}

class InfoCard extends StatelessWidget {
  // the values we need
  final String text;
  final IconData icon;
  Function onPressed;

  InfoCard({required this.text, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          text,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20,
              fontFamily: "Source Sans Pro"),
        ),
      ),
    );
  }
}

class ProfileWidget {
  static Widget profileBody(BuildContext context, CustomUser user) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Text(
          user.displayName ??= 'Loading',
          style: TextStyle(
            fontSize: 40.0,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontFamily: "Pacifico",
          ),
        ),
        Text(
          (user.donator ??= false) ? "Donor" : "Receiver",
          style: TextStyle(
              fontSize: 30,
              color: Colors.blueGrey[200],
              letterSpacing: 2.5,
              fontWeight: FontWeight.bold,
              fontFamily: "Source Sans Pro"),
        ),
        SizedBox(
          height: 20,
          width: 200,
          child: Divider(
            color: Colors.white,
          ),
        ),

        // we will be creating a new widget name info carrd
        InfoCard(
            text: user.phoneNumber ??= "Loading",
            icon: Icons.phone,
            onPressed: () async {}),
        InfoCard(
            text: user.description ??= "Loading",
            icon: Icons.web,
            onPressed: () async {}),
        // InfoCard(
        //     text: "location",
        //     icon: Icons.location_city,
        //     onPressed: () async {}),
        InfoCard(
            text: user.email ??= "Loading",
            icon: Icons.email,
            onPressed: () async {}),
      ],
    );
  }
}

class ListViewFactory {
  static Widget listingsListView(
      BuildContext context, List<Donation> donations) {
    Database.getAllDonations();

    return ListView.builder(
        itemCount: donations.length,
        itemBuilder: (context, index) {
          var donation = donations[index];
          return Card(
            child: ListTile(
              title: Text(donation.title ?? "Not Set"),
              subtitle: Text(donation.description ?? "N/A"),
              trailing: Text(
                  donation.available ?? true ? "Available" : "Unavailable"),
              leading: Text(
                donation.quantity ?? 0.toString(),
                style: const TextStyle(fontSize: 30),
              ),
            ),
          );
        });

    // return ListView(
    //   children: [
    //     ListTile(
    //       title: Text("Title"),
    //       subtitle: Text('This is the description'),
    //       trailing: Text("Available"),
    //       leading: Text(
    //         3.toString(),
    //         style: TextStyle(fontSize: 30),
    //       ),
    //     ),
    //   ],
    // );
  }
}
