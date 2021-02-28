import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yuk_chat/models/user_app.dart';
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
    UserApp user = await UserService.getUser(uid);
    Timestamp time = Timestamp.now();
    _ref.doc(uid + time.toString()).set({
      "id": uid + time.toString(),
      "text": msg,
      "createdAt": time,
      "userId": uid,
      "username": user.username,
      "imageUrl": user.imageUrl,
    });
  }

  static void deleteMessage(String msgId) async {
    await _ref.doc(msgId).delete();
  }
}
