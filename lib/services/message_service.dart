import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yuk_chat/services/auth_service.dart';

class MessageService {
  static final CollectionReference _ref = FirebaseFirestore.instance
      .collection("chats/8RUCaz8ysGcJOzj5LJx7/messages");

  static Stream<QuerySnapshot> getChat() {
    return _ref.orderBy("createdAt", descending: true).snapshots();
  }

  static void sendMessage(String msg) {
    _ref.add({
      "text": msg,
      "createdAt": Timestamp.now(),
      "userId": AuthService.currentUser().uid,
    });
  }
}
