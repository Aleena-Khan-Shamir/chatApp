import 'package:flutter/material.dart';

class MessageBubbles extends StatelessWidget {
  const MessageBubbles(
      {super.key,
      required this.messages,
      required this.isMe,
      required this.userName,
      required this.userImage});
  final String messages;
  final String userName;
  final String userImage;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(userImage),
        ),
        const SizedBox(width: 5),
        Align(
          alignment: Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: isMe
                    ? Colors.grey.shade400
                    : Theme.of(context).primaryColor.withOpacity(0.4),
                borderRadius: BorderRadius.only(
                    topRight: const Radius.circular(15),
                    topLeft: isMe
                        ? const Radius.circular(15)
                        : const Radius.circular(0),
                    bottomLeft: const Radius.circular(15),
                    bottomRight: isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userName,
                      style: TextStyle(
                          color: isMe
                              ? Theme.of(context).primaryColor
                              : Colors.black54,
                          fontWeight: FontWeight.bold)),
                  Text(
                    messages,
                    style: TextStyle(
                      color: isMe ? Colors.black : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
