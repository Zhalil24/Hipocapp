import 'package:flutter/material.dart';
import 'package:hipocapp/product/widget/circle_avatar/custom_circle_avatar.dart';
import 'package:kartal/kartal.dart';

class UserListWidget extends StatefulWidget {
  const UserListWidget({super.key, this.photoURL, this.username, required this.onTop, this.unreadMessageCount, required this.isOnline});
  final String? photoURL;
  final String? username;
  final VoidCallback onTop;
  final int? unreadMessageCount;
  final bool? isOnline;

  @override
  State<UserListWidget> createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<UserListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomCircleAvatar(
        imageURL: widget.photoURL ?? '',
        radius: context.sized.normalValue,
      ),
      title: Text(widget.username ?? 'Bilinmeyen'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: context.sized.lowValue,
            height: context.sized.lowValue,
            margin: EdgeInsets.only(right: context.sized.lowValue),
            decoration: BoxDecoration(
              color: (widget.isOnline ?? false) ? Colors.green : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),

          // 🔴 unread count varsa göster
          if ((widget.unreadMessageCount ?? 0) > 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: context.sized.lowValue, vertical: context.sized.lowValue * 0.5),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${widget.unreadMessageCount}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      onTap: widget.onTop,
    );
  }
}
