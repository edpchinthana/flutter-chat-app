import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBox extends StatefulWidget {
  final Function(String message) addMessageToGroupChat;

  const MessageBox({Key key, this.addMessageToGroupChat}) : super(key: key);
  @override
  _MessageBoxState createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_MessageBoxState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width-130,
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Enter your message here",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter your message to continue';
                  }
                  return null;
                },
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          RaisedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
               await widget.addMessageToGroupChat(_controller.text);
                _controller.clear();
              }
            },
            child: Row(
              children: [
                Icon(Icons.send),
                SizedBox(width: 4,),
                Text('SEND')
              ],
            ),
          )
        ],
      ),
    );
  }
}
