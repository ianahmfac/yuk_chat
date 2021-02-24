import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:yuk_chat/services/image_upload_service.dart';
import 'package:yuk_chat/services/user_service.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static Future signInWithEmailPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e.message;
    } catch (e) {
      throw e;
    }
  }

  static Future signUp(
      String email, String username, String password, File image) async {
    try {
      final UserCredential credential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final String imageUrl = await ImageUploadService.getImageUrl(image);

      UserService.setNewUser(
        credential.user.uid,
        credential.user.email,
        username,
        imageUrl,
      );
    } on FirebaseAuthException catch (e) {
      throw e.message;
    } catch (e) {
      throw e;
    }
  }

  static User currentUser() => _auth.currentUser;

  static Future signOut() => _auth.signOut();

  static Stream<User> loginSession = _auth.authStateChanges();
}
