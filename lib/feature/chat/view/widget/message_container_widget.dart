import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/utility/constans/message_container/message_container_decoration.dart';
import 'package:kartal/kartal.dart';

class MessageContainerWidget extends StatefulWidget {
  const MessageContainerWidget({super.key, required this.isMe, required this.message, required this.date});
  final bool isMe;
  final String message;
  final String date;
  @override
  State<MessageContainerWidget> createState() => _MessageContainerWidgetState();
}

class _MessageContainerWidgetState extends State<MessageContainerWidget> {
  String _formatDate(String dateStr) {
    try {
      final dateTime = DateTime.parse(dateStr);
      return DateFormat('dd.MM.yyyy HH:mm').format(dateTime);
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: context.sized.lowValue),
      padding: EdgeInsets.all(context.sized.normalValue),
      decoration: MessageContainerDecoration(isMe: widget.isMe, context: context),
      child: Column(
        crossAxisAlignment: widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.message,
            style: TextStyle(
              color: widget.isMe ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: context.sized.lowValue),
          Text(
            _formatDate(widget.date),
            style: TextStyle(
              color: widget.isMe ? Colors.white70 : Colors.black54,
              fontSize: context.sized.lowValue * 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
