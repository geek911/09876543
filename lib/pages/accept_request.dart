import 'package:flutter/material.dart';
import 'package:food_donor/database.dart';
import 'package:food_donor/repositories/donations_repository.dart';

class AcceptRequest extends StatefulWidget {
  const AcceptRequest({Key? key}) : super(key: key);

  @override
  State<AcceptRequest> createState() => _AcceptRequestState();
}

class _AcceptRequestState extends State<AcceptRequest> {
  List<Donation> donations = [];

  @override
  void initState() {
    Database.donationsToBeApproved().then((value) {
      setState(() {});
      donations = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Database.donationsToBeApproved().then((value) {
      setState(() {});
      donations = value;
    });
    return Scaffold(
        appBar: AppBar(title: Text('Accept Bookings')),
        body: ListView.builder(
            itemCount: donations.length,
            itemBuilder: (context, index) {
              var donation = donations[index];
              return ListTile(
                  title: Text(donation.title!),
                  subtitle: Text("${donation.description} ${donation.by}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(donation.status ?? "n/a"),
                      IconButton(
                        icon: Icon(
                          Icons.approval,
                          color: Colors.green.shade600,
                        ),
                        onPressed: () {
                          Database.approve(donation).then((e) {
                            setState(() {});
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        color: Colors.red.shade600,
                        onPressed: () {
                          Database.declined(donation).then((e) {
                            setState(() {});
                          });
                        },
                      ),
                    ],
                  ));
            }));
  }
}
