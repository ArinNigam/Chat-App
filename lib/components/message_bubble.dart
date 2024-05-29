import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String? text;
  final String? sender;
  final bool? isMe;
  const MessageBubble({super.key, this.sender, this.text, this.isMe});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: Column(
        crossAxisAlignment:
            isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '~$sender',
            style: const TextStyle(fontSize: 15.0),
          ),
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.only(
              topLeft: isMe!
                  ? const Radius.circular(30.0)
                  : const Radius.circular(0),
              topRight: isMe!
                  ? const Radius.circular(0.0)
                  : const Radius.circular(30.0),
              bottomLeft: const Radius.circular(30.0),
              bottomRight: const Radius.circular(30.0),
            ),
            color: isMe! ? const Color(0xFF8ac926) : const Color(0xFFccd5ae),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '$text',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Arial'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
