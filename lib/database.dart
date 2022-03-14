import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';


class Database {
  static final FirebaseDatabase _db = FirebaseDatabase.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> addProfile(Map<String, dynamic> profile) async {
    DatabaseReference reference = _db.ref(_auth.currentUser?.uid as String);

    await reference.set(profile);
  }
}