import 'package:flutter/material.dart';
import 'package:yuk_chat/services/message_service.dart';

class ChatInput extends StatefulWidget {
  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  String _currentMessage = "";
  TextEditingController _chatController = TextEditingController();

  void _sendMessage() {
    FocusManager.instance.primaryFocus.unfocus();
    setState(() {
      MessageService.sendMessage(_currentMessage);
      _currentMessage = "";
      _chatController.clear();
    });
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(16),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black54,
                ),
                alignment: Alignment.center,
                child: TextField(
                  controller: _chatController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (value) {
                    setState(() {
                      _currentMessage = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Ketikkan pesan...",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
            _currentMessage.trim().isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _sendMessage,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
