import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/auth/profile/view_model/state/profile_view_state.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/product/navigation/app_router.dart';
import 'package:hipocapp/product/service/interface/entry_operation.dart';
import 'package:hipocapp/product/service/interface/follow_operation.dart';
import 'package:hipocapp/product/service/interface/profile_operation.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';
import 'package:hipocapp/product/state/view_model/product_view_model.dart';
import 'package:hipocapp/product/utility/enums/profile_tab_type.dart';
import 'package:vexana/vexana.dart';

final class ProfileViewModel extends BaseCubit<ProfileViewState> {
  ProfileViewModel({
    required ProfileOperation profileOperation,
    required ProductViewModel productViewModel,
    required EntryOperation entryOperation,
    required FollowOperation followOperation,
  })  : _profileOperation = profileOperation,
        _productViewModel = productViewModel,
        _entryOperation = entryOperation,
        _followOperation = followOperation,
        super(ProfileViewState(isLoading: false));

  late final ProfileOperation _profileOperation;
  late final EntryOperation _entryOperation;
  late final FollowOperation _followOperation;
  File? selectedPhoto;
  late final ProductViewModel _productViewModel;

  void _setLoading(bool value) {
    emit(state.copyWith(isLoading: value));
  }

  void _setFollowActionLoading(bool value) {
    emit(state.copyWith(isFollowActionLoading: value));
  }

  /// Set selected photo
  void updateSelectedPhoto(File photo) {
    selectedPhoto = photo;
    emit(state.copyWith(photo: photo));
  }

  /// Clear service message
  void clearServiceMessage() {
    emit(state.copyWith(serviceResponseMessage: null));
  }

  /// Set service response
  void setServiceRespnonse(String? message) {
    emit(state.copyWith(serviceResponseMessage: message));
  }

  /// Fetch user profile from server with user id from cache.
  ///
  /// After fetching data, emit a new state with the fetched profile model.
  ///
  /// Returns false.
  Future<void> loadProfilePage({
    required int userId,
    required bool isOwnProfile,
  }) async {
    _setLoading(true);
    try {
      final response = await _profileOperation.getProfile(userId);
      emit(state.copyWith(profileModel: response?.profileModel));
      await _loadFollowData(
        targetUserId: userId,
        isOwnProfile: isOwnProfile,
      );
    } finally {
      _setLoading(false);
    }
  }

  /// Update profile with given parameters.
  ///
  /// [name] is the new name of the user.
  ///
  /// [surname] is the new surname of the user.
  ///
  /// [email] is the new email of the user.
  ///
  /// [username] is the new username of the user.
  ///
  /// After updating profile, emit a new state with the updated profile model.
  Future<void> updateProfile(
    String name,
    String surname,
    String email,
    String username,
    int userId,
  ) async {
    _setLoading(true);
    final model = ProfileUpdateModel(
      id: userId,
      email: email,
      name: name,
      photo: state.photo,
      username: username,
      surname: surname,
      password: 'a',
      passwordRe: 'a',
    );
    final response = await _profileOperation.updateProfile(model);
    final updatedProfile = state.profileModel?.copyWith(
      email: email,
      name: name,
      surname: surname,
      username: username,
    );
    emit(state.copyWith(profileModel: updatedProfile));
    _setLoading(false);
    setServiceRespnonse(response?.message);
  }

  /// Change tab bar
  void changeTab(ProfileTabType tab) {
    emit(state.copyWith(activeTab: tab));
  }

  /// Logout
  Future<void> logout(BuildContext context) async {
    await _productViewModel.onLogout();
    if (context.mounted) {
      await context.router.replaceAll([
        const HomeRoute(),
      ]);
    }
    setServiceRespnonse(LocaleKeys.auth_profile_logout_success.tr());
  }

  Future<void> changePassword(
    String password,
    String newpassword,
    String newrepassword,
    int userId,
  ) async {
    _setLoading(true);
    final model = ChangePasswordModel(
      newpassword: newpassword,
      newrepassword: newrepassword,
      password: password,
      userid: userId,
    );
    final message = await _profileOperation.changePassword(model);
    setServiceRespnonse(message);
    _setLoading(false);
  }

  /// Delete an entry with the given [id].
  ///
  /// After deleting the entry, update the profile model with the new entry list.
  /// Also, update the active tab to [ProfileTabType.entries].
  ///
  Future<void> deleteEntry(int id) async {
    _setLoading(true);
    final resp = await _entryOperation.deleteEntry(id);
    final updatedEntries = List<EntryModel>.from(
      state.profileModel?.entries ?? [],
    );
    updatedEntries.removeWhere((entry) => entry.id == id);
    final updatedProfile =
        state.profileModel?.copyWith(entries: updatedEntries);
    emit(
      state.copyWith(
        profileModel: updatedProfile,
        activeTab: ProfileTabType.entries,
      ),
    );
    _setLoading(false);
    setServiceRespnonse(resp?.message);
  }

  Future<void> toggleFollow({
    required int targetUserId,
    required String? targetUserName,
  }) async {
    final currentUserId = _productViewModel.state.currentUserId;
    if (currentUserId == null || currentUserId <= 0) {
      return;
    }

    final isFollowing = state.followStatusModel?.isFollowing ?? false;
    debugPrint(
      '[FOLLOW][UI] toggleFollow triggered '
      'currentUserId=$currentUserId '
      'targetUserId=$targetUserId '
      'isFollowing=$isFollowing',
    );
    _setFollowActionLoading(true);

    try {
      if (isFollowing) {
        final response = await _followOperation.unfollow(
          followerUserId: currentUserId,
          followingUserId: targetUserId,
        );
        if (response?.isSuccess != true) {
          setServiceRespnonse(
            response?.message ??
                LocaleKeys.auth_profile_follow_action_failed.tr(),
          );
          return;
        }
        _applyLocalFollowState(
          targetUserId: targetUserId,
          targetUserName: targetUserName,
          isFollowing: false,
        );
        setServiceRespnonse(response?.message);
      } else {
        final response = await _followOperation.follow(
          FollowModel(
            followerUserId: currentUserId,
            followingUserId: targetUserId,
          ),
        );
        if (response?.isSuccess != true) {
          setServiceRespnonse(
            response?.message ??
                LocaleKeys.auth_profile_follow_action_failed.tr(),
          );
          return;
        }
        _applyLocalFollowState(
          targetUserId: targetUserId,
          targetUserName: targetUserName,
          isFollowing: true,
          followDate: response?.followModel?.followDate,
        );
        setServiceRespnonse(response?.message);
      }
    } catch (error, stackTrace) {
      debugPrint('[FOLLOW][UI][EXCEPTION] $error');
      debugPrint('[FOLLOW][UI][STACK] $stackTrace');
      setServiceRespnonse(_extractFollowErrorMessage(error));
    } finally {
      _setFollowActionLoading(false);
    }
  }

  Future<void> _loadFollowData({
    required int targetUserId,
    required bool isOwnProfile,
  }) async {
    try {
      final followCountResponse =
          await _followOperation.getCounts(targetUserId);
      final followersResponse =
          await _followOperation.getFollowers(targetUserId);
      final followingResponse =
          await _followOperation.getFollowing(targetUserId);

      FollowStatusModel? followStatusModel;
      final currentUserId = _productViewModel.state.currentUserId;
      if (!isOwnProfile && currentUserId != null && currentUserId > 0) {
        final statusResponse = await _followOperation.getStatus(
          followerUserId: currentUserId,
          followingUserId: targetUserId,
        );
        followStatusModel = statusResponse?.followStatusModel;
      }

      emit(
        state.copyWith(
          followCountModel: followCountResponse?.followCountModel,
          followers: followersResponse?.users ?? const <FollowUserItemModel>[],
          following: followingResponse?.users ?? const <FollowUserItemModel>[],
          followStatusModel: followStatusModel,
        ),
      );
    } catch (error, stackTrace) {
      debugPrint('[FOLLOW][LOAD][EXCEPTION] $error');
      debugPrint('[FOLLOW][LOAD][STACK] $stackTrace');
      emit(
        state.copyWith(
          followCountModel: null,
          followers: const <FollowUserItemModel>[],
          following: const <FollowUserItemModel>[],
          followStatusModel: null,
        ),
      );
    }
  }

  void _applyLocalFollowState({
    required int targetUserId,
    required String? targetUserName,
    required bool isFollowing,
    DateTime? followDate,
  }) {
    final currentUserId = _productViewModel.state.currentUserId;
    if (currentUserId == null) {
      return;
    }

    final currentFollowersCount = state.followCountModel?.followersCount ?? 0;
    final updatedFollowers = List<FollowUserItemModel>.from(state.followers);

    if (isFollowing) {
      final alreadyExists = updatedFollowers.any(
        (item) => item.followerUserId == currentUserId,
      );
      if (!alreadyExists) {
        updatedFollowers.insert(
          0,
          FollowUserItemModel(
            followerUserId: currentUserId,
            followingUserId: targetUserId,
            followerUserName: _productViewModel.state.userName,
            followingUserName:
                targetUserName ?? state.profileModel?.username ?? '',
            followDate: followDate ?? DateTime.now(),
          ),
        );
      }
    } else {
      updatedFollowers.removeWhere(
        (item) => item.followerUserId == currentUserId,
      );
    }

    emit(
      state.copyWith(
        followers: updatedFollowers,
        followCountModel:
            (state.followCountModel ?? FollowCountModel()).copyWith(
          userId: state.followCountModel?.userId ?? targetUserId,
          followersCount: isFollowing
              ? currentFollowersCount + 1
              : (currentFollowersCount > 0 ? currentFollowersCount - 1 : 0),
          followingCount: state.followCountModel?.followingCount ?? 0,
        ),
        followStatusModel:
            (state.followStatusModel ?? FollowStatusModel()).copyWith(
          followerUserId: currentUserId,
          followingUserId: targetUserId,
          isFollowing: isFollowing,
          followDate: isFollowing ? (followDate ?? DateTime.now()) : null,
        ),
      ),
    );
  }

  String _extractFollowErrorMessage(Object error) {
    if (error is DioException) {
      final data = error.response?.data;
      if (data is Map<String, dynamic>) {
        final message = data['message'];
        if (message is String && message.trim().isNotEmpty) {
          return message;
        }
      }
    }

    return LocaleKeys.auth_profile_follow_action_failed.tr();
  }
}
