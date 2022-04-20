import 'package:firebase_auth/firebase_auth.dart';

class Receiver {
  String? id;
  String? displayName;
  String? email;
  bool donator = false;
  String? description;
  String? location;
  String? password;
  String? phoneNumber;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, dynamic> toProfileJson() {
    return {
      "description": description ??= "na",
      "phone_number": phoneNumber ??= "na",
      "donator": donator,
      "email": email ??='na'
    };
  }

  Receiver fromProfileJson(Map<String, dynamic> json) {
    description = json['description'];
    phoneNumber = json['phone_number'];
    donator = json['donator'];
    displayName = json['displayName'];
    donator = json['donator'];
    displayName = _auth.currentUser?.displayName;
    email = _auth.currentUser?.email;

    return this;
  }
}
