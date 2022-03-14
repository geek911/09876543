import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:food_donor/models/custom_user.dart';

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
    var phone_number = snapshot.snapshot.child('phone_number').value;

    return CustomUser().fromProfileJson({
      'description': description,
      'donator': donator,
      'phone_number': phone_number
    });
  }
}
