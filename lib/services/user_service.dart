import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yuk_chat/models/user_app.dart';

class UserService {
  static CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection("users");

  static Future setNewUser(String uid, String email, String username) async {
    await _collectionRef.doc(uid).set({
      "email": email,
      "username": username,
    });
  }

  static Future<UserApp> getUser(String uid) async {
    final DocumentSnapshot doc = await _collectionRef.doc(uid).get();
    final Map<String, dynamic> user = doc.data();
    return UserApp(
      email: user["email"],
      username: user["email"],
    );
  }
}
