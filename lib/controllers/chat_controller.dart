import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/views/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatController extends GetxController {
  // Application will only allocate memory for _auth variable, when it is accessed during run time.
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // FirebaseUser = User
  late User loggedInUser;
  final messages = <Message>[].obs;

  @override
  void onInit() {
    messages.bindStream(getStream());
    getCurrentUser();
    super.onInit();
  }

  void getCurrentUser() {
    try {
      // Returns the current User if they are currently signed-in, or null if not.
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print("Oho: " + loggedInUser.toString());
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  void sendMessage(
      {required String messageText,
      required TextEditingController textEditingController}) {
    textEditingController.clear();
    _firestore.collection('messages').add({
      'sender': loggedInUser.email,
      'text': messageText,
      'time': DateTime.now().millisecondsSinceEpoch,
    });
  }

  // Stream <List<Message>>: We will get list of Message in future.
  Stream<List<Message>> getStream() {
    Stream<QuerySnapshot<Map<String, dynamic>>> stream =
        _firestore.collection('messages').orderBy("time").snapshots();
    return (stream.map((querySnapshot) => querySnapshot.docs
        .map((document) => Message(
            sender: document.data()['sender'],
            text: document.data()['text'],
            time: DateTime.now().millisecondsSinceEpoch))
        .toList()));
  }

  void signOut() {
    _auth.signOut();
    Get.offAllNamed(WelcomeScreen.id);
  }
}
