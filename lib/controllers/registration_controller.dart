import 'package:chat_app/views/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationController extends GetxController {
  // To authenticate user
  final _auth = FirebaseAuth.instance;

  RxBool showSpinner = false.obs;

  void createUser(
      {required String emailAddress, required String password}) async {
    // true
    showSpinner.toggle();
    try {
      // It returns a future data, so we capture it in newUser final variable.
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: emailAddress, password: password);
      if (newUser.user != null) {
        Get.toNamed(ChatScreen.id);
      }
    } catch (e) {
      Get.snackbar("Error", "Unable to register new user.",
          backgroundColor: Colors.grey);
      // false
      showSpinner.toggle();
      throw Exception(e);
    }
  }
}
