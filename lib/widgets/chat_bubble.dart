import 'package:flutter/material.dart';
import 'package:yuk_chat/services/auth_service.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String userId;
  ChatBubble(this.message, this.userId);
  @override
  Widget build(BuildContext context) {
    bool _isMe = userId == AuthService.currentUser().uid;
    return Row(
      mainAxisAlignment:
          _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: _isMe ? Radius.circular(20) : Radius.circular(0),
              bottomRight: _isMe ? Radius.circular(0) : Radius.circular(20),
            ),
            color: _isMe ? Theme.of(context).accentColor : Colors.grey[300],
          ),
          child: Text(
            message,
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
