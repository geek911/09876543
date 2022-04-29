import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/material/time.dart';

class Donation {
  String? id;
  String? userId;
  String? title;
  String? description;
  String? location;
  String? quantity;
  bool? available = true;
  String? startTime;
  String? status;
  String? endTime;
  String? receiver;
  String? by_id;
  String? by = FirebaseAuth.instance.currentUser?.displayName;
  double? latitude;
  double? longtude;
  String? phoneNumber;
  String? email;

  String? createdOn;

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
      'quantity': quantity,
      'available': available,
      'start_time': startTime,
      'end_time': endTime,
      'created_on': createdOn,
      'by': by,
      'latitude': latitude ?? 0,
      'longtude': longtude ?? 0,
      'phoneNumber': phoneNumber,
      'email': email
    };
  }
}

class DonationsRepository {}
