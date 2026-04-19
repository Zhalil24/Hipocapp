import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/auth/profile/view/mixin/profile_view_mixin.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/change_password_widget.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/edit_profile_widget.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/profile_background_widget.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/profile_entries_tab_widget.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/profile_info_widget.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/profile_page_content_widget.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/profile_page_skeleton_widget.dart';
import 'package:hipocapp/feature/auth/profile/view_model/profile_view_model.dart';
import 'package:hipocapp/feature/auth/profile/view_model/state/profile_view_state.dart';
import 'package:hipocapp/product/navigation/app_router.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/utility/enums/profile_tab_type.dart';
import 'package:hipocapp/product/utility/extension/service_snack_bar.dart';
import 'package:hipocapp/product/widget/login_popup/login_required_popup.dart';

@RoutePage()
class ProfilView extends StatefulWidget {
  const ProfilView({
    super.key,
    this.userId,
    this.username,
  });

  final int? userId;
  final String? username;

  @override
  State<ProfilView> createState() => _ProfilViewState();
}

class _ProfilViewState extends BaseState<ProfilView> with ProfileViewMixin {
  @override
  Widget build(BuildContext context) {
    if (!productViewModel.state.isLogin) {
      return Scaffold(
        body: Stack(
          children: [
            const Positioned.fill(child: ProfileBackgroundWidget()),
            LoginRequiredPopup(
              onLoginPressed: () {
                unawaited(context.router.push(const LoginRoute()));
              },
            ),
          ],
        ),
      );
    }

    final currentUserId = productViewModel.state.currentUserId;
    final isOwnProfile =
        widget.userId == null || widget.userId == currentUserId;

    return BlocProvider(
      create: (_) => profileViewModel,
      child: BlocListener<ProfileViewModel, ProfileViewState>(
        listenWhen: (prev, curr) =>
            prev.serviceResponseMessage != curr.serviceResponseMessage &&
            curr.serviceResponseMessage != null,
        listener: (context, state) {
          final msg = state.serviceResponseMessage;
          if (msg == null) return;
          ScaffoldMessenger.of(context).showSnackBar(
            createServiceSnackBar(msg),
          );
          context.read<ProfileViewModel>().clearServiceMessage();
        },
        child: Scaffold(
          body: BlocBuilder<ProfileViewModel, ProfileViewState>(
            builder: (context, state) {
              if (state.isLoading && state.profileModel == null) {
                return ProfilePageSkeletonWidget(
                  isOwnProfile: isOwnProfile,
                  activeTab: state.activeTab,
                );
              }

              if (isOwnProfile) {
                seedProfileControllers(state.profileModel);
              }

              return ProfilePageContentWidget(
                profileModel: state.profileModel,
                selectedPhoto: isOwnProfile ? state.photo : null,
                activeTab: state.activeTab,
                onLogout: () {
                  unawaited(profileViewModel.logout(context));
                },
                onTabChanged: profileViewModel.changeTab,
                followers: state.followers,
                following: state.following,
                onFollowerSelected: (item) {
                  unawaited(
                    _openProfileFromFollowItem(
                      targetUserId: item.followerUserId,
                      targetUsername: item.followerUserName,
                      currentProfileUserId:
                          state.profileModel?.id ?? widget.userId,
                    ),
                  );
                },
                onFollowingSelected: (item) {
                  unawaited(
                    _openProfileFromFollowItem(
                      targetUserId: item.followingUserId,
                      targetUsername: item.followingUserName,
                      currentProfileUserId:
                          state.profileModel?.id ?? widget.userId,
                    ),
                  );
                },
                followCountModel: state.followCountModel,
                followStatusModel: state.followStatusModel,
                isFollowActionLoading: state.isFollowActionLoading,
                onToggleFollow: isOwnProfile
                    ? null
                    : () {
                        final targetUserId =
                            widget.userId ?? state.profileModel?.id;
                        if (targetUserId == null || targetUserId <= 0) {
                          return;
                        }

                        unawaited(
                          profileViewModel.toggleFollow(
                            targetUserId: targetUserId,
                            targetUserName:
                                state.profileModel?.username ?? widget.username,
                          ),
                        );
                      },
                onMessageTap: isOwnProfile
                    ? null
                    : () {
                        unawaited(_openDirectChat(state));
                      },
                showBlockingLoader: state.isLoading &&
                    (!isOwnProfile || state.profileModel != null),
                isOwnProfile: isOwnProfile,
                fallbackUsername: widget.username,
                child: isOwnProfile
                    ? _buildTabContent(state)
                    : _buildPublicTabContent(state),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(ProfileViewState state) {
    switch (state.activeTab) {
      case ProfileTabType.profile:
        return ProfileInfoWidget(
          profileModel: state.profileModel,
        );
      case ProfileTabType.editProfile:
        return EditProfileWidget(
          selectedPhoto: state.photo,
          currentImageUrl: state.profileModel?.photoURL ?? '',
          onPickImage: pickImageFromGallery,
          nameController: nameController,
          surnameController: surnameController,
          usernameController: usernameController,
          emailController: emailController,
          onUpdate: (name, surname, username, email) {
            unawaited(
              profileViewModel.updateProfile(
                name,
                surname,
                email,
                username,
                productViewModel.state.currentUserId!,
              ),
            );
          },
        );
      case ProfileTabType.changePassword:
        return ChangePasswordWidget(
          passwordChangeController: passwordChangeController,
          newPasswordChangeController: newPasswordChangeController,
          newPasswordReChangeController: newPasswordReChangeController,
          onChangePressed: () {
            unawaited(
              profileViewModel.changePassword(
                passwordChangeController.text,
                newPasswordChangeController.text,
                newPasswordReChangeController.text,
                productViewModel.state.currentUserId!,
              ),
            );
          },
        );
      case ProfileTabType.entries:
        return ProfileEntriesTabWidget(
          profileModel: state.profileModel,
          onDelete: (entryId) {
            unawaited(profileViewModel.deleteEntry(entryId));
          },
        );
    }
  }

  Widget _buildPublicTabContent(ProfileViewState state) {
    if (state.profileModel == null) {
      return const SizedBox.shrink();
    }

    switch (state.activeTab) {
      case ProfileTabType.profile:
        return ProfileInfoWidget(
          profileModel: state.profileModel,
          isPublicProfile: true,
        );
      case ProfileTabType.entries:
        return ProfileEntriesTabWidget(
          profileModel: state.profileModel,
          canDeleteEntries: false,
        );
      case ProfileTabType.editProfile:
      case ProfileTabType.changePassword:
        return ProfileInfoWidget(
          profileModel: state.profileModel,
          isPublicProfile: true,
        );
    }
  }

  Future<void> _openProfileFromFollowItem({
    required int? targetUserId,
    required String? targetUsername,
    required int? currentProfileUserId,
  }) async {
    if (targetUserId == null || targetUserId <= 0) {
      return;
    }

    if (currentProfileUserId != null && currentProfileUserId == targetUserId) {
      return;
    }

    final currentUserId = productViewModel.state.currentUserId;
    if (currentUserId != null && currentUserId == targetUserId) {
      await context.router.push(ProfilRoute());
      return;
    }

    await context.router.push(
      ProfilRoute(
        userId: targetUserId,
        username: targetUsername,
      ),
    );
  }

  Future<void> _openDirectChat(ProfileViewState state) async {
    final targetUserId = widget.userId ?? state.profileModel?.id;
    if (targetUserId == null || targetUserId <= 0) {
      return;
    }

    await context.router.push(
      ChatRoute(
        toUserId: targetUserId,
        toUserName: state.profileModel?.username ?? widget.username ?? '',
        isOnline: state.profileModel?.isOnline ?? false,
      ),
    );
  }
}
