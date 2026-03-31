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
    this.isPublicProfile = false,
  });

  final ProfileModel? profileModel;
  final bool isPublicProfile;

  @override
  Widget build(BuildContext context) {
    if (profileModel == null) {
      return AppEmptyStateCard(
        icon: Icons.person_search_rounded,
        title: LocaleKeys.auth_profile_info_empty_title.tr(),
        message: LocaleKeys.auth_profile_info_empty_message.tr(),
      );
    }

    return _ProfileDetailsCard(
      profileModel: profileModel!,
      isPublicProfile: isPublicProfile,
    );
  }
}

class _ProfileDetailsCard extends StatelessWidget {
  const _ProfileDetailsCard({
    required this.profileModel,
    required this.isPublicProfile,
  });

  final ProfileModel profileModel;
  final bool isPublicProfile;

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
            isPublicProfile
                ? LocaleKeys.general_form_username.tr()
                : LocaleKeys.auth_profile_account_title.tr(),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          if (!isPublicProfile) ...[
            SizedBox(height: low * 0.55),
            Text(
              LocaleKeys.auth_profile_account_description.tr(),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.45,
              ),
            ),
          ],
          SizedBox(height: normal * 1.1),
          if (isPublicProfile)
            _ProfileDetailRow(
              icon: Icons.alternate_email_rounded,
              label: LocaleKeys.general_form_username.tr(),
              value: profileModel.username ?? '-',
              isLast: true,
            ),
          if (!isPublicProfile) ...[
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
