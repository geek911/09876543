import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:food_donor/models/custom_user.dart';
import 'package:food_donor/repositories/donations_repository.dart';

class Database {
  static final FirebaseDatabase _db = FirebaseDatabase.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> addProfile(Map<String, dynamic> profile) async {
    DatabaseReference reference = _db.ref(_auth.currentUser?.uid as String);

    await reference.set(profile);
  }

  static Future<CustomUser> getProfile() async {
    var snapshot = await _db.ref(_auth.currentUser?.uid as String).once();

    var description = snapshot.snapshot.child('description').value;
    var donator = snapshot.snapshot.child('donator').value;
    var phoneNumber = snapshot.snapshot.child('phone_number').value;

    return CustomUser().fromProfileJson({
      'description': description,
      'donator': donator,
      'phone_number': phoneNumber
    });
  }

  static Future<void> addDonation(Map<String, dynamic> donation) async {
    DatabaseReference reference =
        _db.ref('${_auth.currentUser?.uid as String}/donations');
    await reference.push().set(donation);
  }

  static Future<List<Donation>> getAllDonations() async {
    var snapshot = await _db.ref('/').once();
    var donations = <Donation>[];

    for (var child in snapshot.snapshot.children) {
      for (var c in child.child('donations').children) {
        var donation = Donation()
          ..title = c.child('title').value as String?
          ..available = c.child('available').value as bool?
          ..fromDate = c.child('from_date').value as String?
          ..toDate = c.child('to_date').value as String?
          ..description = c.child('description').value as String?
          ..location = c.child('location').value as String?
          ..quantity = c.child('quantity').value as String?;

        donations.add(donation);
      }
    }

    return donations;
  }
}
