import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function (String email, String password, void Function(Exception e) error) signInWithEmailAndPassword;

  SignUp({Key key, this.signInWithEmailAndPassword}) : super(key : key);

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
    return Container(
        child: Center(
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
                            email = value;
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
                          if(email!= null && password2!= null){
                            await widget.signInWithEmailAndPassword(email, password2, (Exception e){
                              showDialog(context: context,
                                  builder:(context){
                                    return AlertDialog(
                                      title: Text("Login failed"),
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
                          }
                        },
                        color: Colors.amber,
                        child: Text(
                          "Login"
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}
