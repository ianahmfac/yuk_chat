import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  static CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection("users");

  static Future setNewUser(String uid, String email, String username) async {
    await _collectionRef.doc(uid).set({
      "email": email,
      "username": username,
    });
  }
}
