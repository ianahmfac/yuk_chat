import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yuk_chat/services/auth_service.dart';
import 'package:yuk_chat/services/user_service.dart';

class MessageService {
  static final CollectionReference _ref = FirebaseFirestore.instance
      .collection("chats/8RUCaz8ysGcJOzj5LJx7/messages");

  static Stream<QuerySnapshot> getChat() {
    return _ref.orderBy("createdAt", descending: true).snapshots();
  }

  static Future sendMessage(String msg) async {
    String uid = AuthService.currentUser().uid;
    Map<String, dynamic> userService = await UserService.getUser(uid);
    String username = userService["username"];
    _ref.add({
      "text": msg,
      "createdAt": Timestamp.now(),
      "userId": uid,
      "username": username,
    });
  }
}
