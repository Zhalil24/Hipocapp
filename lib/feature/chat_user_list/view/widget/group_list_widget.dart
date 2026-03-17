import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class GroupListWidget extends StatelessWidget {
  const GroupListWidget({
    super.key,
    this.groupName,
    this.memberCount,
    required this.onTap,
  });

  final String? groupName;
  final int? memberCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return AppSurfaceCard(
      padding: EdgeInsets.symmetric(
        horizontal: normal,
        vertical: low * 0.95,
      ),
      margin: EdgeInsets.only(bottom: low * 0.85),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(normal * 1.35),
          onTap: onTap,
          child: Row(
            children: [
              Container(
                width: context.sized.height * 0.068,
                height: context.sized.height * 0.068,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primary.withValues(alpha: 0.86),
                      colorScheme.secondary.withValues(alpha: 0.72),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(normal * 1.15),
                ),
                child: Icon(
                  Icons.groups_rounded,
                  color: colorScheme.onPrimary,
                  size: context.sized.height * 0.03,
                ),
              ),
              SizedBox(width: normal),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      groupName ?? 'Bilinmeyen grup',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: low * 0.32),
                    Text(
                      memberCount != null && memberCount! > 0
                          ? '$memberCount uye ile ortak sohbete katil'
                          : 'Topluluk kanalini ac ve sohbete dogrudan baglan',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: low * 0.75),
              Icon(
                Icons.arrow_forward_rounded,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
