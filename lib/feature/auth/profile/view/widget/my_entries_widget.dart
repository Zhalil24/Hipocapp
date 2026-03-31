import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class MyEntriesWidget extends StatelessWidget {
  const MyEntriesWidget({
    super.key,
    required this.titleName,
    required this.desc,
    this.onPressed,
    this.canDelete = true,
  });

  final String titleName;
  final String desc;
  final VoidCallback? onPressed;
  final bool canDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return AppSurfaceCard(
      padding: EdgeInsets.all(normal * 0.95),
      margin: EdgeInsets.only(bottom: normal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: context.sized.height * 0.05,
                height: context.sized.height * 0.05,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(normal),
                ),
                child: Icon(
                  Icons.auto_stories_outlined,
                  color: colorScheme.primary,
                ),
              ),
              SizedBox(width: normal * 0.8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: low * 0.35),
                    Text(
                      LocaleKeys.auth_profile_my_entry_subtitle.tr(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: normal),
          Text(
            desc,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.55,
            ),
          ),
          if (canDelete) ...[
            SizedBox(height: normal),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: () => _showDeleteDialog(context),
                icon: const Icon(Icons.delete_outline_rounded),
                label: Text(LocaleKeys.auth_profile_delete_entry_button.tr()),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colorScheme.error,
                  side: BorderSide(
                    color: colorScheme.error.withValues(alpha: 0.42),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(normal),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _showDeleteDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(LocaleKeys.auth_profile_delete_entry_title.tr()),
          content: Text(
            LocaleKeys.auth_profile_delete_entry_message.tr(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(LocaleKeys.general_button_cancel.tr()),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(LocaleKeys.general_button_delete.tr()),
            ),
          ],
        );
      },
    );

    if ((result ?? false) && onPressed != null) {
      onPressed?.call();
    }
  }
}
