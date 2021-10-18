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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentUser();
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

  void sendMessage({required messageText}) {
    _firestore.collection('messages').add({
      'sender': loggedInUser.email,
      'text': messageText,
    });
  }

  void signOut() {
    _auth.signOut();
    Get.offAllNamed(WelcomeScreen.id);
  }
}
