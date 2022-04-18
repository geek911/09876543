import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
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
  static Future _showDialog(BuildContext context, Donation donation) async {
    return showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
        title: const Text("Selected Donation"),
        content: Container(
          child: const Text('Are you interested in the selected donation?'),
        ),
        actions: <Widget>[
          BasicDialogAction(
            title: const Text("Interested"),
            onPressed: () {
              Database.interested(donation);
              Navigator.pop(context);
            },
          ),
          BasicDialogAction(
            title: Text("Not Interested"),
            onPressed: () {
              Database.uninterested(donation);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  static Widget listingsListView(BuildContext context, List<Donation> donations,
      [bool isOwner = true]) {
    return ListView.builder(
        itemCount: donations.length,
        itemBuilder: (context, index) {
          var donation = donations[index];

          var subtitle =
              "${donation.description ?? 'N/A'}, DATE: ${donation.createdOn} ${donation.startTime ?? 'N/A'} - ${donation.endTime ?? 'N/A'}";

          return Card(
            child: ListTile(
              title: Text(donation.title ?? "Not Set"),
              subtitle: Text(subtitle),
              trailing: Text(
                  (donation.available ??= false) ? "Available" : "Unavailable"),
              leading: Text(
                donation.quantity ?? 0.toString(),
                style: const TextStyle(fontSize: 30),
              ),
              onTap: () async {
                // await _showDialog(context, isOwner, donation);
              },
            ),
          );
        });
  }

  static Widget donorListingsListView(
      BuildContext context, List<Donation> donations,
      [bool isOwner = true]) {
    return ListView.builder(
        itemCount: donations.length,
        itemBuilder: (context, index) {
          var donation = donations[index];

          var subtitle =
              "${donation.description ?? 'N/A'}, DATE: ${donation.createdOn} ${donation.startTime ?? 'N/A'} - ${donation.endTime ?? 'N/A'}";

          return Card(
            child: ListTile(
              title: Text(donation.title ?? "Not Set"),
              subtitle: Text(subtitle),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () async {
                  Database.deleteDonation(donation);
                },
              ),
              leading: Text(
                donation.quantity ?? 0.toString(),
                style: const TextStyle(fontSize: 30),
              ),
              onTap: () async {
                Navigator.of(context).pushNamed('/accept');
              },
            ),
          );
        });
  }

  static Widget donorlistingsListView(
      BuildContext context, List<Donation> donations,
      [bool isOwner = true]) {
    return ListView.builder(
        itemCount: donations.length,
        itemBuilder: (context, index) {
          var donation = donations[index];

          var subtitle =
              "${donation.description ?? 'N/A'}, DATE: ${donation.createdOn} ${donation.startTime ?? 'N/A'} - ${donation.endTime ?? 'N/A'}";

          return Card(
            child: ListTile(
              title: Text(donation.title ?? "Not Set"),
              subtitle: Text(subtitle),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  await Database.deleteDonation(donation);
                },
              ),
              leading: Text(
                donation.quantity ?? 0.toString(),
                style: const TextStyle(fontSize: 30),
              ),
              onTap: () {
                // await _showDialog(context, isOwner, donation);
                Navigator.of(context).pushNamed('/accept');
              },
            ),
          );
        });
  }

  static Widget receiverlistingsListView(
      BuildContext context, List<Donation> donations,
      [bool isOwner = true]) {
    return ListView.builder(
        itemCount: donations.length,
        itemBuilder: (context, index) {
          var donation = donations[index];

          var subtitle =
              "${donation.description ?? 'N/A'}, DATE: ${donation.createdOn} ${donation.startTime ?? 'N/A'} - ${donation.endTime ?? 'N/A'}";

          return Card(
            child: ListTile(
              title: Text(donation.title ?? "Not Set"),
              subtitle: Text(subtitle),
              trailing: Text('Pending'),
              leading: Text(
                donation.quantity ?? 0.toString(),
                style: const TextStyle(fontSize: 30),
              ),
              onTap: () {
                // Navigator.of(context).pushNamed('/book');
                _showDialog(context, donation);
              },
            ),
          );
        });
  }

  static Widget interestedlistingsListView(
      BuildContext context, List<Donation> donations,
      [bool isOwner = true]) {
    return ListView.builder(
        itemCount: donations.length,
        itemBuilder: (context, index) {
          var donation = donations[index];

          var subtitle =
              "${donation.description ?? 'N/A'}, DATE: ${donation.createdOn} ${donation.startTime ?? 'N/A'} - ${donation.endTime ?? 'N/A'}";

          return Card(
            child: ListTile(
              title: Text(donation.title ?? "Not Set"),
              subtitle: Text(subtitle),
              trailing: Text(donation.status ?? 'n/a'),
              leading: Text(
                donation.quantity ?? 0.toString(),
                style: const TextStyle(fontSize: 30),
              ),
              onTap: () {
                // Navigator.of(context).pushNamed('/book');
                _showDialog(context, donation);
              },
            ),
          );
        });
  }
}
