import 'package:chatapp/ui/auth/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final Function (String email, String password, void Function(Exception e) error) signInWithEmailAndPassword;

  Login({Key key, this.signInWithEmailAndPassword}) : super(key : key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("User Login",
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
                          hintText: "Email Address"
                        ),
                        onChanged: (value){
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Password"
                        ),
                        onChanged: (value){
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          if(email!= null && password!= null){
                            await widget.signInWithEmailAndPassword(email, password, (Exception e){
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
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                          text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                              text:"Don't have an account yet? ",
                            style: TextStyle(
                              color: Colors.amber
                            )
                          ),
                          TextSpan(
                          text:"Register !",
                              style: TextStyle(
                                  color: Colors.blue
                              ),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignUp()),
                                );
                              },)
                              ]
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
