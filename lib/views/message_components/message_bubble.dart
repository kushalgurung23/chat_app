import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String messageText, messageSender;
  final bool isMe;
  const MessageBubble(
      {Key? key,
      required this.messageText,
      required this.messageSender,
      required this.isMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            messageSender,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 5.0),
          Material(
              borderRadius: BorderRadius.only(
                topLeft:
                    isMe ? const Radius.circular(30) : const Radius.circular(0),
                bottomLeft: const Radius.circular(30),
                bottomRight: const Radius.circular(30),
                topRight:
                    isMe ? const Radius.circular(0) : const Radius.circular(30),
              ),
              elevation: 5.0,
              color: isMe ? Colors.lightBlueAccent : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  messageText,
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
