import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({
    super.key,
    required this.profileModel,
  });

  final ProfileModel? profileModel;

  @override
  Widget build(BuildContext context) {
    if (profileModel == null) {
      return AppEmptyStateCard(
        icon: Icons.person_search_rounded,
        title: LocaleKeys.auth_profile_info_empty_title.tr(),
        message: LocaleKeys.auth_profile_info_empty_message.tr(),
      );
    }

    final normal = context.sized.normalValue;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 900;
        final accountCard = _ProfileDetailsCard(profileModel: profileModel!);
        final statusCard = _ProfileStatusCard(profileModel: profileModel!);

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: accountCard),
              SizedBox(width: normal),
              Expanded(child: statusCard),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            accountCard,
            SizedBox(height: normal),
            statusCard,
          ],
        );
      },
    );
  }
}

class _ProfileDetailsCard extends StatelessWidget {
  const _ProfileDetailsCard({
    required this.profileModel,
  });

  final ProfileModel profileModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.auth_profile_account_title.tr(),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: low * 0.55),
          Text(
            LocaleKeys.auth_profile_account_description.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          SizedBox(height: normal * 1.1),
          _ProfileDetailRow(
            icon: Icons.badge_outlined,
            label: LocaleKeys.general_form_name.tr(),
            value: profileModel.name ?? '-',
          ),
          _ProfileDetailRow(
            icon: Icons.credit_card_rounded,
            label: LocaleKeys.general_form_surname.tr(),
            value: profileModel.surname ?? '-',
          ),
          _ProfileDetailRow(
            icon: Icons.alternate_email_rounded,
            label: LocaleKeys.general_form_username_lower.tr(),
            value: profileModel.username ?? '-',
          ),
          _ProfileDetailRow(
            icon: Icons.mail_outline_rounded,
            label: LocaleKeys.general_form_email.tr(),
            value: profileModel.email ?? '-',
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _ProfileStatusCard extends StatelessWidget {
  const _ProfileStatusCard({
    required this.profileModel,
  });

  final ProfileModel profileModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;
    final entries = profileModel.entries?.length ?? 0;

    return AppSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.auth_profile_community_title.tr(),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: low * 0.55),
          Text(
            LocaleKeys.auth_profile_community_description.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          SizedBox(height: normal * 1.1),
          _StatusHighlight(
            icon: Icons.school_outlined,
            title: LocaleKeys.auth_profile_degree_title.tr(),
            message: profileModel.degreeModel?.degreeName ??
                LocaleKeys.general_fallback_degree_not_added.tr(),
          ),
          SizedBox(height: normal * 0.8),
          _StatusHighlight(
            icon: Icons.auto_stories_outlined,
            title: LocaleKeys.auth_profile_published_content_title.tr(),
            message: LocaleKeys.general_count_published_entries.tr(
              namedArgs: {'count': '$entries'},
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileDetailRow extends StatelessWidget {
  const _ProfileDetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isLast = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final low = context.sized.lowValue;
    final normal = context.sized.normalValue;

    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : low * 0.75),
      padding: EdgeInsets.all(normal * 0.85),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(normal),
      ),
      child: Row(
        children: [
          Container(
            width: context.sized.height * 0.045,
            height: context.sized.height * 0.045,
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: colorScheme.primary,
              size: context.sized.normalValue,
            ),
          ),
          SizedBox(width: normal * 0.85),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: low * 0.25),
                Text(
                  value,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusHighlight extends StatelessWidget {
  const _StatusHighlight({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final low = context.sized.lowValue;

    return Container(
      padding: EdgeInsets.all(context.sized.normalValue),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.76),
        borderRadius: BorderRadius.circular(context.sized.normalValue * 1.05),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.16),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: colorScheme.primary,
          ),
          SizedBox(width: context.sized.normalValue * 0.8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: low * 0.3),
                Text(
                  message,
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
    );
  }
}
