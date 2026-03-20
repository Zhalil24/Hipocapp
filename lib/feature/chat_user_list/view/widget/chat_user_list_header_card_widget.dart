import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/product/utility/enums/chat_tab_type.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class ChatUserListHeaderCardWidget extends StatelessWidget {
  const ChatUserListHeaderCardWidget({
    super.key,
    required this.activeTab,
    required this.usersCount,
    required this.conversationCount,
    required this.groupCount,
    required this.unreadTotal,
  });

  final ChatTabType activeTab;
  final int usersCount;
  final int conversationCount;
  final int groupCount;
  final int unreadTotal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;
    final title = _titleFor(activeTab);
    final description = _descriptionFor(activeTab);

    return AppSurfaceCard(
      padding: EdgeInsets.all(context.sized.height * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: context.sized.height * 0.07,
                height: context.sized.height * 0.07,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primary.withValues(alpha: 0.90),
                      colorScheme.secondary.withValues(alpha: 0.72),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(normal * 1.25),
                ),
                child: Icon(
                  _iconFor(activeTab),
                  color: colorScheme.onPrimary,
                  size: context.sized.height * 0.032,
                ),
              ),
              SizedBox(width: normal),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: low * 0.45),
                    Text(
                      description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: normal * 1.1),
          Wrap(
            spacing: low * 0.75,
            runSpacing: low * 0.75,
            children: [
              _MetricChip(
                icon: Icons.people_alt_rounded,
                label: LocaleKeys.general_count_person.tr(
                  namedArgs: {'count': '$usersCount'},
                ),
              ),
              _MetricChip(
                icon: Icons.forum_rounded,
                label: LocaleKeys.general_count_conversation.tr(
                  namedArgs: {'count': '$conversationCount'},
                ),
              ),
              _MetricChip(
                icon: Icons.groups_rounded,
                label: LocaleKeys.general_count_group.tr(
                  namedArgs: {'count': '$groupCount'},
                ),
              ),
            ],
          ),
          if (unreadTotal > 0) ...[
            SizedBox(height: normal),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(normal),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(normal * 1.25),
                border: Border.all(
                  color: colorScheme.primary.withValues(alpha: 0.12),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.mark_chat_unread_rounded,
                    color: colorScheme.primary,
                    size: context.sized.normalValue * 1.15,
                  ),
                  SizedBox(width: low * 0.75),
                  Expanded(
                    child: Text(
                      LocaleKeys.general_count_unread_messages.tr(
                        namedArgs: {'count': '$unreadTotal'},
                      ),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _titleFor(ChatTabType tab) {
    switch (tab) {
      case ChatTabType.users:
        return LocaleKeys.chat_user_list_header_users_title.tr();
      case ChatTabType.pastMessages:
        return LocaleKeys.chat_user_list_header_past_messages_title.tr();
      case ChatTabType.groups:
        return LocaleKeys.chat_user_list_header_groups_title.tr();
    }
  }

  String _descriptionFor(ChatTabType tab) {
    switch (tab) {
      case ChatTabType.users:
        return LocaleKeys.chat_user_list_header_users_description.tr();
      case ChatTabType.pastMessages:
        return LocaleKeys.chat_user_list_header_past_messages_description.tr();
      case ChatTabType.groups:
        return LocaleKeys.chat_user_list_header_groups_description.tr();
    }
  }

  IconData _iconFor(ChatTabType tab) {
    switch (tab) {
      case ChatTabType.users:
        return Icons.person_search_rounded;
      case ChatTabType.pastMessages:
        return Icons.chat_bubble_rounded;
      case ChatTabType.groups:
        return Icons.groups_rounded;
    }
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final low = context.sized.lowValue;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.sized.normalValue * 0.82,
        vertical: low * 0.82,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(context.sized.normalValue * 1.4),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: colorScheme.primary,
            size: context.sized.normalValue,
          ),
          SizedBox(width: low * 0.55),
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
