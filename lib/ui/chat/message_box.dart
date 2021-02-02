import 'package:chatapp/models/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  final Message message;
  final bool isLoggedUser;

  const MessageBox({Key key, this.message, this.isLoggedUser}) : super(key: key);

  String generateDate(DateTime date){
    String year = date.year.toString();
     String month = date.month.toString();
     String day = date.day.toString();
     String hours = date.hour.toString();
     String mins = date.minute.toString();
     return year+"-"+month+"-"+day+"  "+hours+":"+mins;
  }

  @override
  Widget build(BuildContext context) {
    String date = generateDate(message.timestamp);
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
          color: isLoggedUser? Color.fromRGBO(185, 237, 199, 1) : Color.fromRGBO(185, 225, 237, 1),
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              isLoggedUser?"You":message.displayName.toString(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Text(message.message,
              style: TextStyle(
                fontSize: 18,
                
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
              child: Text(date)),
        ],
      ),
    );
  }
}
