import 'package:chatapp/ui/chat/chat_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function (String email, String displayName, String password, void Function(Exception e) error) registerAccount;

  SignUp({Key key, this.registerAccount}) : super(key : key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String displayName;
  String password1;
  String password2;
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat App - SignUp"
        ),
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("User SignUp",
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "Display Name"
                          ),
                          onChanged: (value){
                            setState(() {
                              displayName = value;
                            });
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "Email Address"
                          ),
                          onChanged: (value){
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "Password"
                          ),
                          onChanged: (value){
                            setState(() {
                              password1 = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "Re-Enter Password"
                          ),
                          onChanged: (value){
                            setState(() {
                              password2 = value;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          onPressed: () async {
                            if(displayName!=null && email!= null && password2!= null && password1!=null){
                              if(password1 == password2){
                                bool result = await widget.registerAccount(email, displayName ,password1, (Exception e){
                                  showDialog(context: context,
                                      builder:(context){
                                        return AlertDialog(
                                          title: Text("SignUp failed"),
                                          content: Text(
                                              e.toString()
                                          ),
                                          actions: [
                                            RaisedButton(
                                                child:  Text("OK"),
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                })
                                          ],
                                        );
                                      }
                                  );
                                });

                                if(result){
                                  showDialog(context: context,
                                      builder:(context){
                                        return AlertDialog(
                                          title: Text("New user created successfully!"),
                                          content: Text(
                                              "Please login to use your account"
                                          ),
                                          actions: [
                                            RaisedButton(
                                                child:  Text("OK"),
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                })
                                          ],
                                        );
                                      }
                                  );
                                }
                              }else{
                                showDialog(context: context,
                                    builder:(context){
                                      return AlertDialog(
                                        title: Text("Passwords didn't match."),
                                        content: Text(
                                            "Please try again!"
                                        ),
                                        actions: [
                                          RaisedButton(
                                              child:  Text("OK"),
                                              onPressed: (){
                                                Navigator.pop(context);
                                              })
                                        ],
                                      );
                                    }
                                );
                              }
                            }
                          },
                          color: Colors.amber,
                          child: Text(
                              "SignUp"
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
