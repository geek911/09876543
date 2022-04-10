import 'package:food_donor/repositories/donations_repository.dart';

class Interested {
  String? donationId;
  bool? interested = false;
  bool? received = false;

  toJson() {
    return {
      'donation_id': donationId,
      'interested': interested,
      'received': received
    };
  }
}
