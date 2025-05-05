import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/auth/profile/view_model/state/profile_view_state.dart';
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
  })  : _profileOperation = profileOperation,
        _userCacheOperation = userCacheOperation,
        _entryOperation = entryOperation,
        super(ProfileViewState(isLoading: false));

  late final ProfileOperation _profileOperation;
  late final EntryOperation _entryOperation;
  late final HiveCacheOperation<UserCacheModel> _userCacheOperation;
  late final File? selectedPhoto;

  /// Change loading state
  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  /// Saves the service response message.
  void serviceResponseMessageSave(String? message) {
    emit(state.copyWith(seviceResultMessage: message));
  }

  /// Set selected photo
  void updateSelectedPhoto(File photo) {
    selectedPhoto = photo;
    emit(state.copyWith(photo: photo));
  }

  int _getUserId() {
    final cachedUser = _userCacheOperation.get('user_token');
    int userId = cachedUser!.userId;
    return userId;
  }

  Future<bool> getProfile() async {
    changeLoading();
    int id = _getUserId();
    final response = await _profileOperation.getProfile(id);
    emit(state.copyWith(profileModel: response?.profileModel));
    emit(state.copyWith(seviceResultMessage: response?.message));
    changeLoading();
    return false;
  }

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
    );
    var response = await _profileOperation.updateProfile(model);
    emit(state.copyWith(seviceResultMessage: response?.message));

    changeLoading();
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
    if (context.mounted) {
      await context.router.pushAndPopUntil(
        const LoginRoute(),
        predicate: (_) => false,
      );
    }
  }

  Future<void> changePassword(String password, String newpassword, String newrepassword) async {
    changeLoading();
    final model = ChangePasswordModel(
      newpassword: newpassword,
      newrepassword: newrepassword,
      password: password,
      userid: _getUserId(),
    );
    var response = await _profileOperation.changePassword(model);
    emit(state.copyWith(seviceResultMessage: response));
    changeLoading();
  }

  Future<String> deleteEntry(int id) async {
    changeLoading();
    var response = await _entryOperation.deleteEntry(id);
    final updatedEntries = List<EntryModel>.from(state.profileModel?.entries ?? []);
    updatedEntries.removeWhere((entry) => entry.id == id);
    final updatedProfile = state.profileModel?.copyWith(entries: updatedEntries);
    emit(state.copyWith(profileModel: updatedProfile));
    emit(state.copyWith(activeTab: ProfileTabType.entries));
    serviceResponseMessageSave(response?.message);
    changeLoading();

    return response?.message ?? '';
  }
}
