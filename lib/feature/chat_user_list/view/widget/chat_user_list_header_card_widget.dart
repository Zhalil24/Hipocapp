import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class ChatUserListHeaderCardWidget extends StatelessWidget {
  const ChatUserListHeaderCardWidget({
    super.key,
    required this.usersCount,
    required this.conversationCount,
    required this.channelCount,
  });

  final int usersCount;
  final int conversationCount;
  final int channelCount;

  @override
  Widget build(BuildContext context) {
    final low = context.sized.lowValue;

    return AppSurfaceCard(
      padding: EdgeInsets.all(context.sized.height * 0.028),
      child: Wrap(
        spacing: low * 0.85,
        runSpacing: low * 0.85,
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
            icon: Icons.campaign_rounded,
            label: LocaleKeys.general_count_channel.tr(
              namedArgs: {'count': '$channelCount'},
            ),
          ),
        ],
      ),
    );
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
