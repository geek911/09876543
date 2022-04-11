import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class CustomUser {
  String? id;
  String? firstName;
  String? lastName;
  String? displayName;
  String? email;
  bool? donator;
  String? description;
  String? location;
  String? password;
  String? phoneNumber;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, dynamic> toProfileJson() {
    return {
      "description": description ??= "na",
      "phone_number": phoneNumber ??= "na",
      "donator": donator ??= false,
      "email": email ?? ""
    };
  }

  CustomUser fromProfileJson(Map<String, dynamic> json) {
    description = json['description'];
    phoneNumber = json['phone_number'];
    donator = json['donator'];
    displayName = _auth.currentUser?.displayName;
    email = _auth.currentUser?.email;

    return this;
  }
}
