import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yuk_chat/models/message_model.dart';
import 'package:yuk_chat/services/message_service.dart';
import 'package:yuk_chat/widgets/chat_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: MessageService.getChat(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SpinKitFadingCircle(
            color: Theme.of(context).accentColor,
          );
        }
        final List<QueryDocumentSnapshot> messages = snapshot.data.docs;
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 8),
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final MessageModel message =
                MessageService.getData(messages[index]);
            return ChatBubble(msg: message);
          },
        );
      },
    );
  }
}
