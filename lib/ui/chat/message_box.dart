import 'package:chatapp/models/message.dart';
import 'package:flutter/cupertino.dart';

class MessageBox extends StatelessWidget {
  final Message message;

  const MessageBox({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(message.displayName.toString()),
          Text(message.message),
          Text(message.timestamp.toString()),
        ],
      ),
    );
  }
}
