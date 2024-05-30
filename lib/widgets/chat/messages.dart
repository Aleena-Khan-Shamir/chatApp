import 'package:chat_app/widgets/chat/message_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (chatSnapshot.hasData) {
          final chatDocs = chatSnapshot.data.docs;
          return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (_, index) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: MessageBubbles(
                messages: chatDocs[index]['text'],
                userName: chatDocs[index]['username'],
                isMe: chatDocs[index]['userId'] ==
                    FirebaseAuth.instance.currentUser!.uid,
                userImage: chatDocs[index]['userImage'],
              ),
            ),
          );
        }

        return const Center(child: Text('No data found'));
      },
    );
  }
}
