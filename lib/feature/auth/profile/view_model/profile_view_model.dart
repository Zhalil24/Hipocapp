import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/auth/profile/view_model/state/profile_view_state.dart';
import 'package:hipocapp/product/cache/model/theme_cache_model.dart';
import 'package:hipocapp/product/cache/model/user_cache_model.dart';
import 'package:hipocapp/product/service/interface/entry_operation.dart';
import 'package:hipocapp/product/service/interface/profile_operation.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';
import 'package:hipocapp/product/utility/enums/profile_tab_type.dart';

import '../../../../product/navigation/app_router.dart';

final class ProfileViewModel extends BaseCubit<ProfileViewState> {
  ProfileViewModel({
    required ProfileOperation profileOperation,
    required EntryOperation entryOperation,
    required HiveCacheOperation<UserCacheModel> userCacheOperation,
    required HiveCacheOperation<ThemeCacheModel> themeCacheOperation,
  })  : _profileOperation = profileOperation,
        _userCacheOperation = userCacheOperation,
        _themeCacheOperation = themeCacheOperation,
        _entryOperation = entryOperation,
        super(ProfileViewState(isLoading: false));

  late final ProfileOperation _profileOperation;
  late final EntryOperation _entryOperation;
  late final HiveCacheOperation<UserCacheModel> _userCacheOperation;
  late final File? selectedPhoto;
  late final HiveCacheOperation<ThemeCacheModel> _themeCacheOperation;

  /// Change loading state
  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
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

  int _getUserId() {
    final cachedUser = _userCacheOperation.get('user_token');
    int userId = cachedUser!.userId;
    return userId;
  }

  /// Fetch user profile from server with user id from cache.
  ///
  /// After fetching data, emit a new state with the fetched profile model.
  ///
  /// Returns false.
  Future<bool> getProfile() async {
    changeLoading();
    int id = _getUserId();
    final response = await _profileOperation.getProfile(id);
    emit(state.copyWith(profileModel: response?.profileModel));
    changeLoading();
    return false;
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
  ) async {
    changeLoading();
    var model = ProfileUpdateModel(
      id: _getUserId(),
      email: email,
      name: name,
      photo: state.photo,
      username: username,
      surname: surname,
      password: 'a',
      passwordRe: 'a',
    );
    var response = await _profileOperation.updateProfile(model);

    changeLoading();
    setServiceRespnonse(response?.message);
  }

  /// Change tab bar
  void changeTab(ProfileTabType tab) {
    changeLoading();
    emit(state.copyWith(activeTab: tab));
    changeLoading();
  }

  /// Logout
  Future<void> logout(BuildContext context) async {
    _userCacheOperation.clear();
    _themeCacheOperation.clear();
    if (context.mounted) {
      await context.router.pushAndPopUntil(
        const LoginRoute(),
        predicate: (_) => false,
      );
    }
    setServiceRespnonse('Başarıyla çıkış yapıldı');
  }

  Future<void> changePassword(String password, String newpassword, String newrepassword) async {
    changeLoading();
    final model = ChangePasswordModel(
      newpassword: newpassword,
      newrepassword: newrepassword,
      password: password,
      userid: _getUserId(),
    );
    var message = await _profileOperation.changePassword(model);
    setServiceRespnonse(message);
    changeLoading();
  }

  /// Delete an entry with the given [id].
  ///
  /// After deleting the entry, update the profile model with the new entry list.
  /// Also, update the active tab to [ProfileTabType.entries].
  ///
  Future<void> deleteEntry(int id) async {
    changeLoading();
    var resp = await _entryOperation.deleteEntry(id);
    setServiceRespnonse(resp?.message);
    final updatedEntries = List<EntryModel>.from(state.profileModel?.entries ?? []);
    updatedEntries.removeWhere((entry) => entry.id == id);
    final updatedProfile = state.profileModel?.copyWith(entries: updatedEntries);
    emit(state.copyWith(profileModel: updatedProfile));
    emit(state.copyWith(activeTab: ProfileTabType.entries));
    changeLoading();
  }
}
