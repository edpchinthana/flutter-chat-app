import 'package:chatapp/models/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  final Message message;
  final bool isLoggedUser;

  const MessageBox({Key key, this.message, this.isLoggedUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      color: isLoggedUser? Colors.blue : Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              isLoggedUser?"You":message.displayName.toString()),
          Text(message.message),
          Text(message.timestamp.toIso8601String()),
        ],
      ),
    );
  }
}
