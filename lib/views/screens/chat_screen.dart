import 'package:chat_app/controllers/chat_controller.dart';
import 'package:chat_app/views/message_components/message_stream.dart';
import 'package:chat_app/views/textfield_components/chat_screen_bottom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  static const String id = "/chat_screen";

  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                chatController.signOut();
              }),
        ],
        title: const Text('⚡️ Chat App'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const <Widget>[
            MessageStream(),
            BottomTextField(),
          ],
        ),
      ),
    );
  }
}
