import 'package:chatapp/models/message.dart';
import 'package:chatapp/ui/chat/message_sender.dart';
import 'package:flutter/cupertino.dart';

class ChatHome extends StatefulWidget {
  final Function(String message) addMessageToGroupChat;
  final List<Message> messages;
  const ChatHome({Key key, this.addMessageToGroupChat, this.messages}) : super(key: key);
  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            
            MessageSender(
              addMessageToGroupChat: widget.addMessageToGroupChat,
            )
          ],
        ),
      ),
    );
  }
}
