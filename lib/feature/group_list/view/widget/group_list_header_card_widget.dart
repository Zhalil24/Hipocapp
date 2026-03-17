import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class GroupListHeaderCardWidget extends StatelessWidget {
  const GroupListHeaderCardWidget({
    required this.groupCount,
    required this.isLoggedIn,
    super.key,
  });

  final int groupCount;
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final low = context.sized.lowValue;
    final normal = context.sized.normalValue;

    return AppSurfaceCard(
      padding: EdgeInsets.all(context.sized.height * 0.026),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: normal * 3.1,
                height: normal * 3.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(low * 2),
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primary.withValues(alpha: 0.92),
                      colorScheme.secondary.withValues(alpha: 0.78),
                    ],
                  ),
                ),
                child: Icon(
                  Icons.forum_rounded,
                  color: colorScheme.onPrimary,
                ),
              ),
              SizedBox(width: low * 1.2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: low * 1.1,
                        vertical: low * 0.75,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.secondary.withValues(
                          alpha: isDark ? 0.18 : 0.12,
                        ),
                        borderRadius: BorderRadius.circular(
                          context.sized.height,
                        ),
                      ),
                      child: Text(
                        'Kanal kesfi',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: colorScheme.secondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: low),
                    Text(
                      'Toplulugunu bul ve akisa katil',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: low * 1.1,
                  vertical: low * 0.85,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(
                    alpha: isDark ? 0.16 : 0.10,
                  ),
                  borderRadius: BorderRadius.circular(context.sized.height),
                ),
                child: Text(
                  '$groupCount kanal',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: normal * 0.9),
          Text(
            isLoggedIn
                ? 'Ilgini ceken kanallari kesfet, katilim talebi gonder ve '
                    'topluluk sohbetlerine hizla dahil ol.'
                : 'Acik kanallari incele. Katilim talebi gondermek icin '
                    'sadece hesabina giris yapman yeterli.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.72),
              height: 1.5,
            ),
          ),
          SizedBox(height: normal * 0.9),
          Wrap(
            spacing: low,
            runSpacing: low,
            children: [
              const _GroupListInfoChip(
                icon: Icons.groups_rounded,
                label: 'Topluluk kanallari',
              ),
              const _GroupListInfoChip(
                icon: Icons.explore_rounded,
                label: 'Yeni ilgi alanlari',
              ),
              _GroupListInfoChip(
                icon: isLoggedIn
                    ? Icons.how_to_reg_rounded
                    : Icons.visibility_rounded,
                label: isLoggedIn ? 'Katilima hazirsin' : 'Kesif modu',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GroupListInfoChip extends StatelessWidget {
  const _GroupListInfoChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final low = context.sized.lowValue;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: low,
        vertical: low * 0.75,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(
          alpha: isDark ? 0.42 : 0.62,
        ),
        borderRadius: BorderRadius.circular(context.sized.height),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: low * 1.8,
            color: colorScheme.primary,
          ),
          SizedBox(width: low * 0.6),
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
