import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AppFollowStatButton extends StatelessWidget {
  const AppFollowStatButton({
    super.key,
    required this.label,
    required this.count,
    required this.onPressed,
  });

  final String label;
  final int count;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final low = context.sized.lowValue;
    final normal = context.sized.normalValue;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(normal * 1.2),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: normal * 0.82,
            vertical: low * 0.82,
          ),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(normal * 1.2),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$count',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onSurface,
                ),
              ),
              SizedBox(height: low * 0.16),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
