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
      'by': by
    };
  }
}

class DonationsRepository {}
