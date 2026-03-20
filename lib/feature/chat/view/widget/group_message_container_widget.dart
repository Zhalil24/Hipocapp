import 'package:flutter/material.dart';
import 'package:hipocapp/feature/chat/view/widget/message_container_widget.dart';

class GroupMessageContainerWidget extends StatelessWidget {
  const GroupMessageContainerWidget({
    super.key,
    required this.isMe,
    required this.message,
    required this.date,
    required this.userName,
  });

  final bool isMe;
  final String message;
  final String date;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return MessageContainerWidget(
      isMe: isMe,
      message: message,
      date: date,
      senderName: userName,
    );
  }
}
