import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/views/screens/welcome_screen.dart';
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
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> sendMessage({required messageText}) async {
    await _firestore.collection('messages').add({
      'sender': loggedInUser.email,
      'text': messageText,
    });
  }

  // void messagesStream() async {
  //   // Subscribed to streams of query snapshots to listen for changes in messages collection.
  //   await for (var snapshot in _firestore.collection('messages').snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message.data()['sender']);
  //     }
  //   }
  // }

  // Stream <List<Message>>: We will get list of Message in future.
  Stream<List<Message>> getStream() {
    Stream<QuerySnapshot<Map<String, dynamic>>> stream =
        _firestore.collection('messages').snapshots();
    return (stream.map((querySnapshot) => querySnapshot.docs
        .map((document) => Message(
            sender: document.data()['sender'], text: document.data()['text']))
        .toList()));
  }

  void signOut() {
    _auth.signOut();
    Get.offAllNamed(WelcomeScreen.id);
  }
}
