import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/profile_background_widget.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/profile_header_card_widget.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/product/utility/enums/profile_tab_type.dart';
import 'package:hipocapp/product/widget/custom_loader/custom_loader_widget.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class ProfilePageContentWidget extends StatelessWidget {
  const ProfilePageContentWidget({
    super.key,
    required this.profileModel,
    required this.selectedPhoto,
    required this.activeTab,
    required this.onLogout,
    required this.onTabChanged,
    required this.child,
    required this.showBlockingLoader,
    required this.isOwnProfile,
    this.fallbackUsername,
  });

  final ProfileModel? profileModel;
  final File? selectedPhoto;
  final ProfileTabType activeTab;
  final VoidCallback onLogout;
  final ValueChanged<ProfileTabType> onTabChanged;
  final Widget child;
  final bool showBlockingLoader;
  final bool isOwnProfile;
  final String? fallbackUsername;

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;
    final tabItems = isOwnProfile
        ? ProfileTabType.values
        : const [
            ProfileTabType.profile,
            ProfileTabType.entries,
          ];

    return Stack(
      children: [
        const Positioned.fill(child: ProfileBackgroundWidget()),
        Positioned.fill(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              normal * 0.82,
              normal * 1.2,
              normal * 0.82,
              normal * 1.5,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1180),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProfileHeaderCardWidget(
                      profileModel: profileModel,
                      selectedPhoto: selectedPhoto,
                      onLogout: onLogout,
                      isOwnProfile: isOwnProfile,
                      fallbackUsername: fallbackUsername,
                    ),
                    SizedBox(height: normal * 1.25),
                    AppSegmentedTabBar<ProfileTabType>(
                      items: tabItems,
                      selectedItem: activeTab,
                      labelBuilder: _tabLabel,
                      iconBuilder: (item) => item.icon,
                      onChanged: onTabChanged,
                    ),
                    SizedBox(height: normal * 1.25),
                    child,
                  ],
                ),
              ),
            ),
          ),
        ),
        if (showBlockingLoader)
          const Positioned.fill(
            child: ColoredBox(
              color: Color(0x33000000),
            ),
          ),
        if (showBlockingLoader)
          const Center(
            child: CustomLoader(),
          ),
      ],
    );
  }

  String _tabLabel(ProfileTabType item) {
    switch (item) {
      case ProfileTabType.profile:
        return LocaleKeys.auth_profile_tab_profile.tr();
      case ProfileTabType.editProfile:
        return LocaleKeys.auth_profile_tab_edit_profile.tr();
      case ProfileTabType.changePassword:
        return LocaleKeys.auth_profile_tab_change_password.tr();
      case ProfileTabType.entries:
        return LocaleKeys.auth_profile_tab_entries.tr();
    }
  }
}
