import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/src/widgets/common/app_surface_card.dart';

class AppEmptyStateCard extends StatelessWidget {
  const AppEmptyStateCard({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return AppSurfaceCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: context.sized.height * 0.085,
            height: context.sized.height * 0.085,
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: colorScheme.primary,
              size: context.sized.height * 0.04,
            ),
          ),
          SizedBox(height: normal),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: low * 0.75),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          if (actionLabel != null && onAction != null) ...[
            SizedBox(height: normal * 1.25),
            OutlinedButton.icon(
              onPressed: onAction,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(actionLabel!),
              style: OutlinedButton.styleFrom(
                minimumSize: Size.fromHeight(context.sized.height * 0.062),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(normal * 1.1),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
