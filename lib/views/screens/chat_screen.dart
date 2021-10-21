import 'package:chat_app/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  static const String id = "/chat_screen";

  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final chatController = Get.find<ChatController>();
  late String messageText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                // chatController.signOut();
                print(chatController.messages[0].text);
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            //     // snapshot in build is asyncSnapshot which is the latest snapshot data in our stream.
            //     stream: FirebaseFirestore.instance
            //         .collection('messages')
            //         .snapshots(),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         final messages = snapshot.data!.docs;
            //         List<Text> messageWidgets = [];
            //         for (var message in messages) {
            //           final messageText = message.data()['text'];
            //           final messageSender = message.data()['sender'];
            //           final messageWidget =
            //               Text("$messageText from $messageSender");
            //           messageWidgets.add(messageWidget);
            //         }
            //         return (const Text("$messageText from $messageSender"));
            //       } else {
            //         return (const Text('No Message'));
            //       }
            //     }),
            GetX<ChatController>(builder: (controller) {
              if (controller.messages.isNotEmpty) {
                List<Text> messageWidgets = [];
                for (var message in controller.messages) {
                  final messageText = message.text;
                  final messageSender = message.sender;
                  final messageWidget =
                      Text("$messageText from $messageSender");
                  messageWidgets.add(messageWidget);
                }
                return SingleChildScrollView(
                  child: Column(
                    children: messageWidgets,
                  ),
                );
              } else {
                return const Center(
                  child: Center(child: CircularProgressIndicator(),),
                );
              }
            }),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await chatController.sendMessage(messageText: messageText);
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
