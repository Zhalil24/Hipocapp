import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AuthDividerLabel extends StatelessWidget {
  const AuthDividerLabel({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: Divider(
            color: colorScheme.outline.withValues(alpha: 0.35),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.sized.lowValue * 1.5),
          child: Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: colorScheme.outline.withValues(alpha: 0.35),
          ),
        ),
      ],
    );
  }
}
