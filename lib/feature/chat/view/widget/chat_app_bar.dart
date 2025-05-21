import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ChatAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ChatAppBar({
    super.key,
    this.userName,
    this.groupName,
    this.isOnline,
    this.showOnlineStatus = true,
  });
  final String? userName;
  final String? groupName;
  final bool? isOnline;
  final bool showOnlineStatus;
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
            (widget.userName?.isNotEmpty ?? false)
                ? widget.userName!
                : (widget.groupName?.isNotEmpty ?? false)
                    ? widget.groupName!
                    : '',
            style: TextStyle(
              fontSize: context.sized.normalValue,
            ),
          ),
          if (widget.showOnlineStatus) ...[
            SizedBox(width: context.sized.lowValue),
            Container(
              width: context.sized.lowValue,
              height: context.sized.lowValue,
              decoration: BoxDecoration(
                color: widget.isOnline == true ? Colors.green : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
