import 'package:cloud_firestore/cloud_firestore.dart';


class Database {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addProfile(Map<String, dynamic> profile) async {
    await _db
        .collection('users')
        .doc()
        .set(profile);
  }
}