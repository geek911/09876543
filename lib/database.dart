import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:food_donor/models/custom_user.dart';
import 'package:food_donor/models/intested.dart';
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

  static Future<void> changeStatus(Donation donation) async {
    await _db
        .ref(
            '${_auth.currentUser?.uid as String}/donations/${donation.id}/available')
        .set(!(donation.available ??= true));

    // reference.snapshot.child(donationId).
  }

  static Future<List<Donation>> getMyDonations() async {
    var donations = <Donation>[];
    var event =
        await _db.ref('${_auth.currentUser?.uid as String}/donations').once();

    for (var child in event.snapshot.children) {
      var donation = Donation()
        ..id = child.key
        ..title = child.child('title').value as String?
        ..available = child.child('available').value as bool?
        ..startTime = child.child('start_time').value as String?
        ..endTime = child.child('end_time').value as String?
        ..description = child.child('description').value as String?
        ..location = child.child('location').value as String?
        ..quantity = child.child('quantity').value as String?
        ..createdOn = child.child('created_on').value as String?;

      donations.add(donation);
    }

    return donations;
  }

  static Future<List<Donation>> getAllDonations() async {
    var snapshot = await _db.ref('/').once();
    var donations = <Donation>[];

    for (var child in snapshot.snapshot.children) {
      for (var c in child.child('donations').children) {
        var donation = Donation()
          ..id = c.key
          ..title = c.child('title').value as String?
          ..available = c.child('available').value as bool?
          ..startTime = c.child('start_time').value as String?
          ..endTime = c.child('end_time').value as String?
          ..description = c.child('description').value as String?
          ..location = c.child('location').value as String?
          ..quantity = c.child('quantity').value as String?
          ..createdOn = c.child('created_on').value as String?;

        donations.add(donation);
      }
    }

    return donations;
  }

  static Future<void> intersted(Donation donation, bool interested) async {
    var interest = Interested();
    interest.donationId = donation.id;
    interest.interested = interested;

    if (interested) {
      DatabaseReference reference = _db
          .ref('${_auth.currentUser?.uid as String}/interests/${donation.id}');
      await reference.set(interest.toJson());
    } else {
      DatabaseReference reference = _db
          .ref('${_auth.currentUser?.uid as String}/interests/${donation.id}');
      await reference.remove();
    }
  }

  static Future<List<Donation>> interstedDonations() async {
    var donations = <Donation>[];
    var event =
        await _db.ref('${_auth.currentUser?.uid as String}/interests').once();

    var allDonations = await Database.getAllDonations();

    for (var child in event.snapshot.children) {
      for (var donation in allDonations) {
        if (donation.id == child.key) {
          donations.add(donation);
        }
      }
    }

    return donations;
  }

  static Future<String> getStatus(String donationId) async {
    var event = await _db
        .ref('${_auth.currentUser?.uid as String}/interests/${donationId}')
        .once();

    return event.snapshot.child('received').value == true
        ? 'Approved'
        : 'Pending';
  }
}
