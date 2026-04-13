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
    required this.followers,
    required this.following,
    this.followCountModel,
    this.followStatusModel,
    this.onToggleFollow,
    this.isFollowActionLoading = false,
    this.isOwnProfile = true,
    this.fallbackUsername,
  });

  final ProfileModel? profileModel;
  final File? selectedPhoto;
  final VoidCallback onLogout;
  final List<FollowUserItemModel> followers;
  final List<FollowUserItemModel> following;
  final FollowCountModel? followCountModel;
  final FollowStatusModel? followStatusModel;
  final VoidCallback? onToggleFollow;
  final bool isFollowActionLoading;
  final bool isOwnProfile;
  final String? fallbackUsername;

  @override
  Widget build(BuildContext context) {
    final displayName = _displayName;
    final normal = context.sized.normalValue;
    final followersCount = followCountModel?.followersCount ?? followers.length;
    final followingCount = followCountModel?.followingCount ?? following.length;

    return AppSurfaceCard(
      padding: EdgeInsets.all(context.sized.height * 0.03),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 860;
          final profileSummary = _ProfileSummary(
            displayName: isOwnProfile ? displayName : _publicUserName(context),
            handle: '@${profileModel?.username ?? 'hipocapp'}',
            email: profileModel?.email ??
                LocaleKeys.general_fallback_email_not_added.tr(),
            followersCount: followersCount,
            followingCount: followingCount,
            selectedPhoto: selectedPhoto,
            imageUrl: profileModel?.photoURL ?? '',
            isPublicProfile: !isOwnProfile,
            isFollowing: followStatusModel?.isFollowing ?? false,
            isFollowActionLoading: isFollowActionLoading,
            onFollowersTap: () {
              _showFollowListPopup(
                context,
                title: LocaleKeys.auth_profile_followers_popup_title.tr(),
                emptyMessage:
                    LocaleKeys.auth_profile_followers_empty_message.tr(),
                userNames: _extractFollowerNames(),
              );
            },
            onFollowingTap: () {
              _showFollowListPopup(
                context,
                title: LocaleKeys.auth_profile_following_popup_title.tr(),
                emptyMessage:
                    LocaleKeys.auth_profile_following_empty_message.tr(),
                userNames: _extractFollowingNames(),
              );
            },
            onToggleFollow: onToggleFollow,
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
                SizedBox(width: normal * 1.1),
                Expanded(flex: 2, child: quickActions),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              profileSummary,
              SizedBox(height: normal),
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

  List<String> _extractFollowerNames() {
    return followers
        .map((item) => item.followerUserName?.trim() ?? '')
        .where((name) => name.isNotEmpty)
        .toList();
  }

  List<String> _extractFollowingNames() {
    return following
        .map((item) => item.followingUserName?.trim() ?? '')
        .where((name) => name.isNotEmpty)
        .toList();
  }

  Future<void> _showFollowListPopup(
    BuildContext context, {
    required String title,
    required String emptyMessage,
    required List<String> userNames,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (_) => AppFollowUserListPopup(
        title: title,
        userNames: userNames,
        emptyMessage: emptyMessage,
      ),
    );
  }
}

class _ProfileSummary extends StatelessWidget {
  const _ProfileSummary({
    required this.displayName,
    required this.handle,
    required this.email,
    required this.followersCount,
    required this.followingCount,
    required this.selectedPhoto,
    required this.imageUrl,
    required this.isPublicProfile,
    required this.isFollowing,
    required this.isFollowActionLoading,
    required this.onFollowersTap,
    required this.onFollowingTap,
    this.onToggleFollow,
  });

  final String displayName;
  final String handle;
  final String email;
  final int followersCount;
  final int followingCount;
  final File? selectedPhoto;
  final String imageUrl;
  final bool isPublicProfile;
  final bool isFollowing;
  final bool isFollowActionLoading;
  final VoidCallback onFollowersTap;
  final VoidCallback onFollowingTap;
  final VoidCallback? onToggleFollow;

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
                  SizedBox(height: low * 0.35),
                  Text(
                    handle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (!isPublicProfile) ...[
                    SizedBox(height: low * 0.45),
                    Text(
                      email,
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
        SizedBox(height: normal),
        Wrap(
          spacing: low * 0.75,
          runSpacing: low * 0.75,
          children: [
            AppFollowStatButton(
              label: LocaleKeys.auth_profile_followers.tr(),
              count: followersCount,
              onPressed: onFollowersTap,
            ),
            AppFollowStatButton(
              label: LocaleKeys.auth_profile_following.tr(),
              count: followingCount,
              onPressed: onFollowingTap,
            ),
          ],
        ),
        if (isPublicProfile && onToggleFollow != null) ...[
          SizedBox(height: normal * 0.92),
          SizedBox(
            width: double.infinity,
            child: isFollowing
                ? OutlinedButton.icon(
                    onPressed: isFollowActionLoading ? null : onToggleFollow,
                    icon: isFollowActionLoading
                        ? SizedBox(
                            width: context.sized.normalValue,
                            height: context.sized.normalValue,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: colorScheme.primary,
                            ),
                          )
                        : const Icon(Icons.check_rounded),
                    label: Text(
                      LocaleKeys.auth_profile_following_button.tr(),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize:
                          Size.fromHeight(context.sized.height * 0.056),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(normal * 1.05),
                      ),
                    ),
                  )
                : FilledButton.icon(
                    onPressed: isFollowActionLoading ? null : onToggleFollow,
                    icon: isFollowActionLoading
                        ? SizedBox(
                            width: context.sized.normalValue,
                            height: context.sized.normalValue,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: colorScheme.onPrimary,
                            ),
                          )
                        : const Icon(Icons.person_add_alt_1_rounded),
                    label: Text(
                      LocaleKeys.auth_profile_follow_button.tr(),
                    ),
                    style: FilledButton.styleFrom(
                      minimumSize:
                          Size.fromHeight(context.sized.height * 0.056),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(normal * 1.05),
                      ),
                    ),
                  ),
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
    final low = context.sized.lowValue;
    final selectedLocale =
        context.locale.languageCode == Locales.en.locale.languageCode
            ? Locales.en
            : Locales.tr;

    return Container(
      padding: EdgeInsets.all(normal * 0.68),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(normal * 1.08),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _ProfileMiniPreferenceCard(
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
                            label: Text(LocaleKeys.general_theme_light.tr()),
                          ),
                          ButtonSegment(
                            value: ThemeMode.dark,
                            label: Text(LocaleKeys.general_theme_dark.tr()),
                          ),
                        ],
                        selected: {selectedMode},
                        onSelectionChanged: (values) async {
                          await context
                              .read<ProductViewModel>()
                              .changeThemeMode(
                                values.first,
                              );
                        },
                        showSelectedIcon: false,
                        style: _segmentStyle(context),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: low * 0.72),
              Expanded(
                child: _ProfileMiniPreferenceCard(
                  icon: Icons.language_rounded,
                  child: SegmentedButton<Locales>(
                    segments: [
                      ButtonSegment(
                        value: Locales.tr,
                        label: Text(LocaleKeys.terms_language_tr.tr()),
                      ),
                      ButtonSegment(
                        value: Locales.en,
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
                    showSelectedIcon: false,
                    style: _segmentStyle(context),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: normal * 0.58),
          SizedBox(
            width: double.infinity,
            child: FilledButton.tonalIcon(
              onPressed: onLogout,
              icon: const Icon(Icons.logout_rounded),
              label: Text(LocaleKeys.general_button_secure_logout.tr()),
              style: FilledButton.styleFrom(
                minimumSize: Size.fromHeight(context.sized.height * 0.049),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(normal),
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
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      side: WidgetStatePropertyAll(
        BorderSide(
          color: colorScheme.outline.withValues(alpha: 0.22),
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(normal * 0.9),
        ),
      ),
    );
  }
}

class _ProfileMiniPreferenceCard extends StatelessWidget {
  const _ProfileMiniPreferenceCard({
    required this.icon,
    required this.child,
  });

  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final low = context.sized.lowValue;
    final normal = context.sized.normalValue;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: low * 0.7,
        vertical: low * 0.66,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.84),
        borderRadius: BorderRadius.circular(normal * 0.94),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: colorScheme.primary,
            size: context.sized.normalValue * 0.95,
          ),
          SizedBox(width: low * 0.46),
          Expanded(child: child),
        ],
      ),
    );
  }
}
