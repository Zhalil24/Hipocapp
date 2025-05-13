import 'package:flutter/material.dart';

class ChatAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key, required this.userName});
  final String userName;
  @override
  State<ChatAppBar> createState() => _ChatAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ChatAppBarState extends State<ChatAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.userName,
      ),
      centerTitle: true,
    );
  }
}
