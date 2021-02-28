import 'package:yuk_chat/models/user_app.dart';

class MessageModel {
  final String id;
  final String msg;
  final UserApp user;
  final DateTime time;

  MessageModel({this.id, this.msg, this.user, this.time});
}
