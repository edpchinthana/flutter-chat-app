import 'dart:async';

import 'package:chatapp/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:flutter/material.dart';
import 'application_login_state.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  StreamSubscription<QuerySnapshot> _guestBookSubscription;
  List<Message> _groupChatMessages = [];
  List<Message> get groutChatMessages => _groupChatMessages;

  Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
        _loggedUserId = user.uid;
        _guestBookSubscription = FirebaseFirestore.instance
            .collection('GroupChat')
            .orderBy('timestamp', descending: true).limit(20)
            .snapshots()
            .listen((snapshot) {
          _groupChatMessages = [];
          snapshot.docs.forEach((document) {
            print("Message "+document.data()['message']+" timestamp - "+document.data()['timestamp'].toString());
            _groupChatMessages.add(
              Message(
                timestamp: new DateTime.fromMillisecondsSinceEpoch(document.data()['timestamp']),
                uid:  document.data()['uid'],
                displayName: document.data()['displayName'],
                message: document.data()['message'],
              ),
            );
          });
          notifyListeners();
        });
      } else {
        _loginState = ApplicationLoginState.loggedOut;
        _groupChatMessages = [];
        _guestBookSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  ApplicationLoginState _loginState;
  ApplicationLoginState get loginState => _loginState;

  String _loggedUserId;
  String get loggedUserId => _loggedUserId;

  String _email;
  String get email => _email;


  void signInWithEmailAndPassword(
      String email,
      String password,
      void Function(FirebaseAuthException e) errorCallback,
      ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }


  Future<bool> registerAccount(String email, String displayName, String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user.updateProfile(displayName: displayName);
      return true;
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
      return false;
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<DocumentReference> addMessageToGroupChat(String message) {
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance.collection('GroupChat').add({
      'message': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'displayName': FirebaseAuth.instance.currentUser.displayName,
      'uid': FirebaseAuth.instance.currentUser.uid,
    });
  }
}