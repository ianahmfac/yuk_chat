import 'package:flutter/material.dart';
import 'package:yuk_chat/screens/auth_screen.dart';
import 'package:yuk_chat/screens/chat_screen.dart';
import 'package:yuk_chat/services/auth_service.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService.loginSession,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ChatScreen();
        }
        return AuthScreen();
      },
    );
  }
}
