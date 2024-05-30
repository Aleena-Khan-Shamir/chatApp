import 'package:chat_app/widgets/chat/messages.dart';
import 'package:chat_app/widgets/chat/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
        actions: [
          TextButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              child: const Text('Logout'))
        ],
      ),
      body: const Column(
        children: [
          Expanded(child: Messages()),
          NewMessages(),
        ],
      ),
    );
  }
}
