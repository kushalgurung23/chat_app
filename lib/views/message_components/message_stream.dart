import 'package:chat_app/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'message_bubble.dart';

class MessageStream extends StatelessWidget {
  const MessageStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ChatController>(builder: (controller) {
      if (controller.messages.isNotEmpty) {
        List<MessageBubble> listOfMessageBubbles = [];
        for (var message in controller.messages.reversed) {
          final messageText = message.text;
          final messageSender = message.sender;
          final messageBubble = MessageBubble(
            messageText: messageText,
            messageSender: messageSender,
            isMe: controller.loggedInUser.email.toString() == messageSender,
          );
          listOfMessageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: listOfMessageBubbles,
          ),
        );
      } else {
        return const Center(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }
}
