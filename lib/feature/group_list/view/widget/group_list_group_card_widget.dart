import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class GroupListGroupCardWidget extends StatelessWidget {
  const GroupListGroupCardWidget({
    required this.group,
    required this.isLoggedIn,
    required this.onJoinGroup,
    super.key,
  });

  final GroupListModel group;
  final bool isLoggedIn;
  final Future<void> Function(int groupId) onJoinGroup;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final low = context.sized.lowValue;
    final normal = context.sized.normalValue;
    final groupName = _groupName;
    final createdOn = _formattedCreatedOn;
    final description = _description;

    return AppSurfaceCard(
      padding: EdgeInsets.all(context.sized.height * 0.024),
      margin: EdgeInsets.only(bottom: low * 0.9),
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
                  borderRadius: BorderRadius.circular(normal),
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primary.withValues(alpha: 0.92),
                      colorScheme.secondary.withValues(alpha: 0.78),
                    ],
                  ),
                ),
                child: Icon(
                  Icons.groups_2_rounded,
                  color: colorScheme.onPrimary,
                ),
              ),
              SizedBox(width: low * 1.1),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      groupName,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        height: 1.12,
                      ),
                    ),
                    if (createdOn != null) ...[
                      SizedBox(height: low * 0.55),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule_rounded,
                            size: low * 1.75,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          SizedBox(width: low * 0.5),
                          Expanded(
                            child: Text(
                              createdOn,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: low,
                  vertical: low * 0.7,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(
                    alpha: isDark ? 0.16 : 0.10,
                  ),
                  borderRadius: BorderRadius.circular(context.sized.height),
                ),
                child: Text(
                  LocaleKeys.general_status_open_channel.tr(),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: normal * 0.8),
          Text(
            description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.76),
              height: 1.5,
            ),
          ),
          SizedBox(height: normal * 0.9),
          Wrap(
            spacing: low,
            runSpacing: low,
            children: [
              _MetaPill(
                icon: Icons.forum_outlined,
                label: LocaleKeys.group_list_card_chip_feed.tr(),
              ),
              _MetaPill(
                icon: Icons.chat_bubble_outline_rounded,
                label: LocaleKeys.group_list_card_chip_shared_chat.tr(),
              ),
              _MetaPill(
                icon: isLoggedIn
                    ? Icons.how_to_reg_rounded
                    : Icons.lock_outline_rounded,
                label: isLoggedIn
                    ? LocaleKeys.group_list_card_chip_request.tr()
                    : LocaleKeys.group_list_card_chip_login_required.tr(),
              ),
            ],
          ),
          SizedBox(height: normal * 0.9),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(low),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(
                alpha: isDark ? 0.34 : 0.58,
              ),
              borderRadius: BorderRadius.circular(low * 1.3),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  isLoggedIn ? Icons.bolt_rounded : Icons.info_outline_rounded,
                  size: low * 1.9,
                  color: colorScheme.primary,
                ),
                SizedBox(width: low * 0.7),
                Expanded(
                  child: Text(
                    isLoggedIn
                        ? LocaleKeys.group_list_card_info_logged_in.tr()
                        : LocaleKeys.group_list_card_info_logged_out.tr(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isLoggedIn && group.id != null) ...[
            SizedBox(height: normal),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () async {
                  await onJoinGroup(group.id!);
                },
                icon: const Icon(Icons.arrow_outward_rounded),
                label: Text(LocaleKeys.general_button_join_channel.tr()),
                style: FilledButton.styleFrom(
                  minimumSize: Size.fromHeight(context.sized.height * 0.06),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(normal * 1.05),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String get _groupName {
    final name = group.groupName?.trim();
    if (name == null || name.isEmpty) {
      return LocaleKeys.group_list_card_unnamed.tr();
    }
    return name;
  }

  String get _description {
    final value = group.description?.trim();
    if (value == null || value.isEmpty) {
      return LocaleKeys.group_list_card_default_description.tr();
    }
    return value;
  }

  String? get _formattedCreatedOn {
    final value = group.createdOn;
    if (value == null || value.isEmpty) return null;

    final parsed = DateTime.tryParse(value);
    if (parsed == null) return null;

    return LocaleKeys.group_list_card_created_on.tr(
      namedArgs: {'date': DateFormat('dd.MM.yyyy').format(parsed)},
    );
  }
}

class _MetaPill extends StatelessWidget {
  const _MetaPill({
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
        vertical: low * 0.7,
      ),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(
          alpha: isDark ? 0.12 : 0.08,
        ),
        borderRadius: BorderRadius.circular(context.sized.height),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: low * 1.75,
            color: colorScheme.primary,
          ),
          SizedBox(width: low * 0.6),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
