import 'package:chat_app/constants.dart';
import 'package:chat_app/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomTextField extends StatefulWidget {
  const BottomTextField({Key? key}) : super(key: key);

  @override
  State<BottomTextField> createState() => _BottomTextFieldState();
}

class _BottomTextFieldState extends State<BottomTextField> {
  final messageTextController = TextEditingController();

  final chatController = Get.find<ChatController>();

  late String messageText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kMessageContainerDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: messageTextController,
              onChanged: (value) {
                messageText = value;
              },
              decoration: kMessageTextFieldDecoration,
            ),
          ),
          TextButton(
            onPressed: () {
              if (messageText != '') {
                chatController.sendMessage(
                    messageText: messageText,
                    textEditingController: messageTextController);
                messageText = '';
              }
            },
            child: const Text(
              'Send',
              style: kSendButtonTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
