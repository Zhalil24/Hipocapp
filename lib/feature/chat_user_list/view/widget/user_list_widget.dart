import 'package:flutter/material.dart';
import 'package:hipocapp/product/widget/circle_avatar/custom_circle_avatar.dart';
import 'package:kartal/kartal.dart';

class UserListWidget extends StatefulWidget {
  const UserListWidget({super.key, this.photoURL, this.username, required this.onTop, this.unreadMessageCount});
  final String? photoURL;
  final String? username;
  final VoidCallback onTop;
  final int? unreadMessageCount;

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
      trailing: (widget.unreadMessageCount ?? 0) > 0
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
            )
          : null,
      onTap: widget.onTop,
    );
  }
}
