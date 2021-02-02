import 'package:chatapp/models/message.dart';
import 'package:chatapp/ui/chat/message_box.dart';
import 'package:chatapp/ui/chat/message_sender.dart';
import 'package:flutter/cupertino.dart';

class ChatHome extends StatefulWidget {
  final Function(String message) addMessageToGroupChat;
  final List<Message> messages;
  final String loggedUserId;
  const ChatHome({Key key, this.addMessageToGroupChat, this.messages, this.loggedUserId}) : super(key: key);
  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                height: MediaQuery.of(context).size.height -140,
                child: Column(
                  children: [
                    for(var message in widget.messages)
                      (widget.loggedUserId == message.uid)?
                        Align(
                          alignment: Alignment.centerRight,
                          child: MessageBox(message: message,isLoggedUser: true,),
                        )
                    :
                      Align(
                      alignment: Alignment.centerLeft,
                      child: MessageBox(message: message, isLoggedUser: false,),
                      )
                  ],
                ),
              ),
              MessageSender(
                addMessageToGroupChat: widget.addMessageToGroupChat,
              )
            ],
          ),
        ),
      ),
    );
  }
}
