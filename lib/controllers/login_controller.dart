import 'package:chat_app/views/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  final _auth = FirebaseAuth.instance;
  RxBool showSpinner = false.obs;

  void signInUser({required String emailAddress, required String password}) async {
    // true
    showSpinner.toggle();
    try{
      final result = await _auth.signInWithEmailAndPassword(email: emailAddress, password: password);
      if(result.user != null) {
        Get.offAllNamed(ChatScreen.id);
      }
    }
    catch(e) {
      Get.snackbar("Error", "Login unsuccessful.", backgroundColor: Colors.black38);
      showSpinner(false);
      throw Exception(e);
    }
  }

}