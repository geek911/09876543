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

  String? endTime;

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
      'created_on': createdOn
    };
  }
}

class DonationsRepository {}
