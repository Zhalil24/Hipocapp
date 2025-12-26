import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class GroupListWidget extends StatefulWidget {
  const GroupListWidget({super.key, this.groupName, required this.onTop});

  final String? groupName;
  final VoidCallback onTop;

  @override
  State<GroupListWidget> createState() => _GroupListWidgetState();
}

class _GroupListWidgetState extends State<GroupListWidget> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(context.sized.mediumValue),
      onTap: widget.onTop,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.sized.normalValue,
          vertical: context.sized.lowValue,
        ),
        margin: EdgeInsets.symmetric(
          vertical: context.sized.lowValue * 0.5,
        ),
        decoration: BoxDecoration(
          color: colorScheme.inverseSurface,
          borderRadius: BorderRadius.circular(context.sized.mediumValue),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: context.sized.lowValue,
              offset: Offset(0, context.sized.lowValue * 0.3),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: context.sized.normalValue,
              backgroundColor: Colors.blue.shade100,
              child: Icon(
                Icons.group,
                size: context.sized.normalValue,
                color: Colors.blue.shade700,
              ),
            ),
            SizedBox(width: context.sized.normalValue),
            Expanded(
              child: Text(
                widget.groupName ?? 'Bilinmeyen',
                style: TextStyle(
                  fontSize: context.sized.normalValue,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: context.sized.mediumValue,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
