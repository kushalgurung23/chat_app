import 'package:chat_app/bindings/chat_binding.dart';
import 'package:chat_app/bindings/login_binding.dart';
import 'package:chat_app/bindings/registration_binding.dart';
import 'package:chat_app/views/screens/chat_screen.dart';
import 'package:chat_app/views/screens/login_screen.dart';
import 'package:chat_app/views/screens/registration_screen.dart';
import 'package:chat_app/views/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

// Canonicalized instance: Standard or approved format is the reason for putting const keyword in front of const constructors or classes.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: WelcomeScreen.id,
      getPages: [
        GetPage(name: WelcomeScreen.id, page: () => const WelcomeScreen()),
        GetPage(name: RegistrationScreen.id, page: () => const RegistrationScreen(), binding: RegistrationBinding()),
        GetPage(name: LoginScreen.id, page: () => const LoginScreen(), binding: LoginBinding()),
        GetPage(name: ChatScreen.id, page: () => const ChatScreen(), binding: ChatBinding()),
      ],
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
      },
    );
  }
}
