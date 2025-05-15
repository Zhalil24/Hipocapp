import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ChatAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key, required this.userName, required this.isOnline});
  final String userName;
  final bool isOnline;
  @override
  State<ChatAppBar> createState() => _ChatAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ChatAppBarState extends State<ChatAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            widget.userName,
            style: TextStyle(
              fontSize: context.sized.normalValue,
            ),
          ),
          SizedBox(
            width: context.sized.lowValue,
          ),
          Container(
            width: context.sized.lowValue,
            height: context.sized.lowValue,
            decoration: BoxDecoration(
              color: widget.isOnline ? Colors.green : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
