import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/product/init/product_localization.dart';
import 'package:hipocapp/product/state/view_model/prodcut_state.dart';
import 'package:hipocapp/product/state/view_model/product_view_model.dart';
import 'package:hipocapp/product/utility/enums/locales.dart';
import 'package:hipocapp/product/widget/circle_avatar/custom_circle_avatar.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class ProfileHeaderCardWidget extends StatelessWidget {
  const ProfileHeaderCardWidget({
    super.key,
    required this.profileModel,
    required this.selectedPhoto,
    required this.onLogout,
    this.isOwnProfile = true,
    this.fallbackUsername,
  });

  final ProfileModel? profileModel;
  final File? selectedPhoto;
  final VoidCallback onLogout;
  final bool isOwnProfile;
  final String? fallbackUsername;

  @override
  Widget build(BuildContext context) {
    final displayName = _displayName;
    final entryCount = profileModel?.entries?.length ?? 0;
    final normal = context.sized.normalValue;

    return AppSurfaceCard(
      padding: EdgeInsets.all(context.sized.height * 0.03),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 860;
          final profileSummary = _ProfileSummary(
            displayName: isOwnProfile ? displayName : _publicUserName(context),
            handle: isOwnProfile ? '@${profileModel?.username ?? 'hipocapp'}' : null,
            email: isOwnProfile
                ? profileModel?.email ??
                    LocaleKeys.general_fallback_email_not_added.tr()
                : null,
            degree: isOwnProfile
                ? profileModel?.degreeModel?.degreeName ??
                    LocaleKeys.general_fallback_degree_not_added.tr()
                : null,
            entryCount: isOwnProfile ? entryCount : null,
            selectedPhoto: selectedPhoto,
            imageUrl: profileModel?.photoURL ?? '',
            isPublicProfile: !isOwnProfile,
          );
          final quickActions = _ProfileQuickActions(onLogout: onLogout);

          if (!isOwnProfile) {
            return profileSummary;
          }

          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: profileSummary),
                SizedBox(width: normal * 1.35),
                Expanded(flex: 2, child: quickActions),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              profileSummary,
              SizedBox(height: normal * 1.15),
              quickActions,
            ],
          );
        },
      ),
    );
  }

  String get _displayName {
    final name = profileModel?.name?.trim() ?? '';
    final surname = profileModel?.surname?.trim() ?? '';
    final fullName = '$name $surname'.trim();
    return fullName.isEmpty
        ? LocaleKeys.auth_profile_display_name_fallback.tr()
        : fullName;
  }

  String _publicUserName(BuildContext context) {
    final userName = profileModel?.username?.trim() ?? '';
    if (userName.isNotEmpty) {
      return userName;
    }

    final fallback = fallbackUsername?.trim() ?? '';
    if (fallback.isNotEmpty) {
      return fallback;
    }

    return LocaleKeys.general_fallback_unknown_user.tr();
  }
}

class _ProfileSummary extends StatelessWidget {
  const _ProfileSummary({
    required this.displayName,
    required this.selectedPhoto,
    required this.imageUrl,
    this.handle,
    this.email,
    this.degree,
    this.entryCount,
    this.isPublicProfile = false,
  });

  final String displayName;
  final String? handle;
  final String? email;
  final String? degree;
  final int? entryCount;
  final File? selectedPhoto;
  final String imageUrl;
  final bool isPublicProfile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(low * 0.45),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary.withValues(alpha: 0.28),
                    colorScheme.secondary.withValues(alpha: 0.18),
                  ],
                ),
              ),
              child: selectedPhoto != null
                  ? CircleAvatar(
                      radius: context.sized.height * 0.055,
                      backgroundImage: FileImage(selectedPhoto!),
                    )
                  : CustomCircleAvatar(
                      imageURL: imageUrl,
                      radius: context.sized.height * 0.055,
                      backgroundColor:
                          colorScheme.primary.withValues(alpha: 0.12),
                      icon: Icons.person_outline_rounded,
                    ),
            ),
            SizedBox(width: normal),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (!isPublicProfile && handle != null) ...[
                    SizedBox(height: low * 0.35),
                    Text(
                      handle!,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: low * 0.5),
                    Text(
                      email ?? '',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        if (!isPublicProfile && degree != null && entryCount != null) ...[
          SizedBox(height: normal * 1.1),
          Wrap(
            spacing: low * 0.75,
            runSpacing: low * 0.75,
            children: [
              _ProfileMetricChip(
                icon: Icons.badge_outlined,
                label: degree!,
              ),
              _ProfileMetricChip(
                icon: Icons.auto_stories_rounded,
                label: LocaleKeys.general_count_entry.tr(
                  namedArgs: {'count': '$entryCount'},
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _ProfileQuickActions extends StatelessWidget {
  const _ProfileQuickActions({
    required this.onLogout,
  });

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final normal = context.sized.normalValue;
    final selectedLocale =
        context.locale.languageCode == Locales.en.locale.languageCode
            ? Locales.en
            : Locales.tr;

    return Container(
      padding: EdgeInsets.all(normal),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(normal * 1.35),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ProfileActionRow(
            icon: Icons.light_mode_rounded,
            child: BlocBuilder<ProductViewModel, ProdcutState>(
              buildWhen: (prev, curr) => prev.themeMode != curr.themeMode,
              builder: (context, state) {
                final selectedMode = state.themeMode == ThemeMode.dark
                    ? ThemeMode.dark
                    : ThemeMode.light;

                return SegmentedButton<ThemeMode>(
                  segments: [
                    ButtonSegment(
                      value: ThemeMode.light,
                      icon: const Icon(Icons.light_mode_rounded),
                      label: Text(LocaleKeys.general_theme_light.tr()),
                    ),
                    ButtonSegment(
                      value: ThemeMode.dark,
                      icon: const Icon(Icons.dark_mode_rounded),
                      label: Text(LocaleKeys.general_theme_dark.tr()),
                    ),
                  ],
                  selected: {selectedMode},
                  onSelectionChanged: (values) async {
                    await context.read<ProductViewModel>().changeThemeMode(
                          values.first,
                        );
                  },
                  style: _segmentStyle(context),
                );
              },
            ),
          ),
          SizedBox(height: normal * 0.85),
          _ProfileActionRow(
            icon: Icons.language_rounded,
            child: SegmentedButton<Locales>(
              segments: [
                ButtonSegment(
                  value: Locales.tr,
                  icon: const Icon(Icons.translate_rounded),
                  label: Text(LocaleKeys.terms_language_tr.tr()),
                ),
                ButtonSegment(
                  value: Locales.en,
                  icon: const Icon(Icons.language_rounded),
                  label: Text(LocaleKeys.terms_language_en.tr()),
                ),
              ],
              selected: {selectedLocale},
              onSelectionChanged: (values) async {
                await ProductLocalization.updateLanguage(
                  context: context,
                  value: values.first,
                );
              },
              style: _segmentStyle(context),
            ),
          ),
          SizedBox(height: normal),
          SizedBox(
            width: double.infinity,
            child: FilledButton.tonalIcon(
              onPressed: onLogout,
              icon: const Icon(Icons.logout_rounded),
              label: Text(LocaleKeys.general_button_secure_logout.tr()),
              style: FilledButton.styleFrom(
                minimumSize: Size.fromHeight(context.sized.height * 0.062),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(normal * 1.1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ButtonStyle _segmentStyle(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final normal = context.sized.normalValue;

    return ButtonStyle(
      visualDensity: VisualDensity.compact,
      side: WidgetStatePropertyAll(
        BorderSide(
          color: colorScheme.outline.withValues(alpha: 0.22),
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(normal),
        ),
      ),
    );
  }
}

class _ProfileActionRow extends StatelessWidget {
  const _ProfileActionRow({
    required this.icon,
    required this.child,
  });

  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: normal * 0.82,
        vertical: low * 0.78,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(normal * 1.15),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.16),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: colorScheme.primary,
          ),
          SizedBox(width: low * 0.8),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _ProfileMetricChip extends StatelessWidget {
  const _ProfileMetricChip({
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
        horizontal: context.sized.normalValue * 0.8,
        vertical: low * 0.85,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.84),
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
            size: context.sized.normalValue,
            color: colorScheme.primary,
          ),
          SizedBox(width: low * 0.55),
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
