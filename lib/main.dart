import 'package:chatapp/services/auth/application_login_state.dart';
import 'package:chatapp/services/auth/application_state.dart';
import 'package:chatapp/ui/auth/login.dart';
import 'package:chatapp/ui/chat/chat_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
        create: (context) => ApplicationState(),
        builder: (context, _) => MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          )
        ),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Chat App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          Consumer<ApplicationState>(
            builder: (context, appState, _){
              if(appState.loginState == ApplicationLoginState.loggedIn){
                return RaisedButton(
                    color: Colors.amber,
                    child: Icon(Icons.exit_to_app),
                    onPressed: (){
                        appState.signOut();
                    });
              }
              return Container();
            }
          )
        ],
      ),
      body: Consumer<ApplicationState>(
        builder: (context, appState, _){
          switch(appState.loginState){
            case ApplicationLoginState.loggedIn:{
              return ChatHome(
                addMessageToGroupChat: appState.addMessageToGroupChat,
                messages: appState.groutChatMessages,
                loggedUserId: appState.loggedUserId,
              );
            }
            case ApplicationLoginState.loggedOut:{
              return Login(
                signInWithEmailAndPassword: appState.signInWithEmailAndPassword,
              );
            }
          }
          return Container();
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
