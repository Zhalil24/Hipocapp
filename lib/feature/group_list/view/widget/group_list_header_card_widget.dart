import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
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
                        LocaleKeys.group_list_header_badge.tr(),
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: colorScheme.secondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: low),
                    Text(
                      LocaleKeys.group_list_header_title.tr(),
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
                  LocaleKeys.general_count_channel.tr(
                    namedArgs: {'count': '$groupCount'},
                  ),
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
                ? LocaleKeys.group_list_header_description_logged_in.tr()
                : LocaleKeys.group_list_header_description_logged_out.tr(),
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
              _GroupListInfoChip(
                icon: Icons.groups_rounded,
                label: LocaleKeys.group_list_header_chip_channels.tr(),
              ),
              _GroupListInfoChip(
                icon: Icons.explore_rounded,
                label: LocaleKeys.group_list_header_chip_explore.tr(),
              ),
              _GroupListInfoChip(
                icon: isLoggedIn
                    ? Icons.how_to_reg_rounded
                    : Icons.visibility_rounded,
                label: isLoggedIn
                    ? LocaleKeys.group_list_header_chip_ready.tr()
                    : LocaleKeys.group_list_header_chip_discovery.tr(),
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
