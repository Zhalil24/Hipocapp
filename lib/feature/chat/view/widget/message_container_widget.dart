import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class MessageContainerWidget extends StatelessWidget {
  const MessageContainerWidget({
    super.key,
    required this.isMe,
    required this.message,
    required this.date,
    this.senderName,
  });

  final bool isMe;
  final String message;
  final String date;
  final String? senderName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: context.sized.width * 0.76,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: low * 0.45),
          padding: EdgeInsets.fromLTRB(
            normal,
            low * 0.95,
            normal,
            low * 0.9,
          ),
          decoration: BoxDecoration(
            gradient: isMe
                ? LinearGradient(
                    colors: [
                      colorScheme.primary,
                      colorScheme.secondary.withValues(alpha: 0.84),
                    ],
                  )
                : null,
            color: isMe
                ? null
                : colorScheme.surfaceContainerHighest.withValues(alpha: 0.72),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(normal * 1.25),
              topRight: Radius.circular(normal * 1.25),
              bottomLeft: Radius.circular(isMe ? normal * 1.25 : low * 0.4),
              bottomRight: Radius.circular(isMe ? low * 0.4 : normal * 1.25),
            ),
            border: Border.all(
              color: isMe
                  ? colorScheme.primary.withValues(alpha: 0.28)
                  : colorScheme.outline.withValues(alpha: 0.12),
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withValues(alpha: isMe ? 0.14 : 0.06),
                blurRadius: context.sized.height * 0.018,
                offset: Offset(0, low * 0.45),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if ((senderName?.trim().isNotEmpty ?? false) && !isMe) ...[
                Text(
                  senderName!.trim(),
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: colorScheme.primary,
                  ),
                ),
                SizedBox(height: low * 0.45),
              ],
              Text(
                message,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: isMe ? colorScheme.onPrimary : colorScheme.onSurface,
                  height: 1.45,
                ),
              ),
              SizedBox(height: low * 0.62),
              Text(
                _formatDate(date),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isMe
                      ? colorScheme.onPrimary.withValues(alpha: 0.78)
                      : colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final dateTime = DateTime.parse(dateStr);
      return DateFormat('dd.MM.yyyy HH:mm').format(dateTime);
    } on FormatException {
      return dateStr;
    }
  }
}
