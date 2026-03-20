import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class EntryListHeaderCardWidget extends StatelessWidget {
  const EntryListHeaderCardWidget({
    required this.titleName,
    required this.entryCount,
    required this.isLoggedIn,
    super.key,
  });

  final String titleName;
  final int entryCount;
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
                width: normal * 3,
                height: normal * 3,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(
                    alpha: isDark ? 0.16 : 0.10,
                  ),
                  borderRadius: BorderRadius.circular(low * 2),
                ),
                child: Icon(
                  Icons.auto_stories_rounded,
                  color: colorScheme.primary,
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
                          alpha: isDark ? 0.16 : 0.10,
                        ),
                        borderRadius: BorderRadius.circular(
                          context.sized.height,
                        ),
                      ),
                      child: Text(
                        LocaleKeys.entry_list_header_badge.tr(),
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: colorScheme.secondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: low),
                    Text(
                      titleName,
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
                    alpha: isDark ? 0.16 : 0.08,
                  ),
                  borderRadius: BorderRadius.circular(context.sized.height),
                ),
                child: Text(
                  LocaleKeys.general_count_entry.tr(
                    namedArgs: {'count': '$entryCount'},
                  ),
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: normal),
          Text(
            isLoggedIn
                ? LocaleKeys.entry_list_header_description_logged_in.tr()
                : LocaleKeys.entry_list_header_description_logged_out.tr(),
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
              _MetaChip(
                icon: Icons.chat_bubble_outline_rounded,
                label: LocaleKeys.entry_list_meta_comments.tr(),
              ),
              _MetaChip(
                icon: Icons.schedule_rounded,
                label: LocaleKeys.entry_list_meta_recent.tr(),
              ),
              _MetaChip(
                icon: isLoggedIn ? Icons.edit_note_rounded : Icons.visibility,
                label: isLoggedIn
                    ? LocaleKeys.entry_list_meta_ready.tr()
                    : LocaleKeys.entry_list_meta_read_only.tr(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
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
