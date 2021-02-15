import 'package:flutter/material.dart';
import 'package:yuk_chat/services/auth_service.dart';
import 'package:yuk_chat/widgets/chat_input.dart';
import 'package:yuk_chat/widgets/messages.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yuk Chat!"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => AuthService.signOut(),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Messages(),
          ),
          ChatInput(),
        ],
      ),
    );
  }
}
