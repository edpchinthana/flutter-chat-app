import 'package:chatapp/ui/chat/message_box.dart';
import 'package:flutter/cupertino.dart';

class ChatHome extends StatefulWidget {
  final Function(String message) addMessageToGroupChat;

  const ChatHome({Key key, this.addMessageToGroupChat}) : super(key: key);
  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          MessageBox(
            addMessageToGroupChat: widget.addMessageToGroupChat,
          )
        ],
      ),
    );
  }
}
