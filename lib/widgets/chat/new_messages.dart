import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({
    super.key,
  });

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  String _enteredMessages = '';
  final _controller = TextEditingController();
  void _sendMessages() async {
    FocusScope.of(context).unfocus();
    final auth = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth!.uid)
        .get();
    FirebaseFirestore.instance.collection('chats').add({
      'text': _enteredMessages,
      'createdAt': Timestamp.now(),
      'userId': auth.uid,
      'username': userData['username'],
      'userImage': userData['imageUrl']
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Row(children: [
        Expanded(
            child: TextField(
          controller: _controller,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            labelText: 'Send messages...',
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          onChanged: (value) {
            setState(() {
              _enteredMessages = value;
            });
          },
        )),
        const SizedBox(width: 5),
        IconButton(
            onPressed: _enteredMessages.trim().isEmpty ? null : _sendMessages,
            icon: const Icon(Icons.send))
      ]),
    );
  }
}
