
import 'package:flutter/material.dart';

import 'SelectableBubbleList.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final List<String>? options;
  final Function(String)? onOptionSelected;

  const ChatBubble({super.key, 
    required this.message,
    required this.isMe,
    this.options,
    this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isMe)
                Container(
                  padding: const EdgeInsets.only(right: 7, top: 5),
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://d112y698adiu2z.cloudfront.net/photos/production/software_thumbnail_photos/002/346/888/datas/medium.png'),
                    radius: 15.0,
                  ),
                ),
              Flexible(
                child: Material(
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0),
                    bottomLeft: isMe
                        ? const Radius.circular(20.0)
                        : const Radius.circular(0.0),
                    bottomRight: isMe
                        ? const Radius.circular(0.0)
                        : const Radius.circular(20.0),
                  ),
                  color: isMe ? Colors.lightBlueAccent : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      message,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black54,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (options != null && onOptionSelected != null)
          SelectableBubbleList(
            options: options!,
            onSelected: onOptionSelected!,
          ),
      ],
    );
  }
}

