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
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: context.sized.lowValue * 0.3,
        horizontal: context.sized.lowValue,
      ),
      decoration: BoxDecoration(
        color: colorScheme.inverseSurface,
        borderRadius: BorderRadius.circular(context.sized.lowValue),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: context.sized.lowValue,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        dense: true, // ListTile yüksekliğini küçültür
        contentPadding: EdgeInsets.symmetric(
          vertical: context.sized.lowValue * 0.5,
          horizontal: context.sized.normalValue,
        ),
        leading: Stack(
          clipBehavior: Clip.none,
          children: [
            CustomCircleAvatar(
              imageURL: widget.photoURL ?? '',
              radius: context.sized.highValue * 0.55, // daha küçük avatar
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: context.sized.lowValue * 6.5,
                height: context.sized.lowValue * 1.5,
                decoration: BoxDecoration(
                  color: (widget.isOnline ?? false) ? Colors.green : Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: context.sized.lowValue * 0.3,
                  ),
                ),
              ),
            ),
          ],
        ),
        title: Text(
          widget.username ?? 'Bilinmeyen',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
        ),
        trailing: (widget.unreadMessageCount ?? 0) > 0
            ? Container(
                padding: EdgeInsets.all(context.sized.lowValue * 0.6),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${widget.unreadMessageCount}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: context.sized.lowValue * 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : null,
        onTap: widget.onTop,
      ),
    );
  }
}
