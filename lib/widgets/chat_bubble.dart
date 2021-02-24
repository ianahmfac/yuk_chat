import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yuk_chat/services/auth_service.dart';
import 'package:yuk_chat/shared/theme.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String userId;
  final String username;
  final DateTime time;
  final String imageUrl;
  ChatBubble(
      this.message, this.userId, this.username, this.time, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    bool _isMe = userId == AuthService.currentUser().uid;
    final Widget _profilePhoto = CircleAvatar(
      child: (imageUrl == "") ? Icon(Icons.person) : null,
      backgroundImage: (imageUrl == "") ? null : NetworkImage(imageUrl),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!_isMe) _profilePhoto,
          Card(
            margin: const EdgeInsets.all(8),
            elevation: 4,
            shadowColor: Theme.of(context).accentColor,
            color: _isMe ? Theme.of(context).accentColor : Colors.grey[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: _isMe ? Radius.circular(20) : Radius.circular(0),
                bottomRight: _isMe ? Radius.circular(0) : Radius.circular(20),
              ),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(),
              child: Column(
                crossAxisAlignment:
                    _isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    _isMe ? "saya" : username,
                    style: titleStyle.copyWith(
                      fontSize: 14,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    message,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 18,
                    ),
                    textAlign: _isMe ? TextAlign.end : TextAlign.start,
                  ),
                  Align(
                    alignment:
                        _isMe ? Alignment.centerLeft : Alignment.centerRight,
                    child: Text(
                      DateFormat.Hm().format(time),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isMe) _profilePhoto,
        ],
      ),
    );
  }
}
