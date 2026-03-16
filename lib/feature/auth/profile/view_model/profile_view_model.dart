import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/auth/profile/view_model/state/profile_view_state.dart';
import 'package:hipocapp/product/service/interface/entry_operation.dart';
import 'package:hipocapp/product/service/interface/profile_operation.dart';
import 'package:hipocapp/product/navigation/app_router.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';
import 'package:hipocapp/product/state/view_model/product_view_model.dart';
import 'package:hipocapp/product/utility/enums/profile_tab_type.dart';

final class ProfileViewModel extends BaseCubit<ProfileViewState> {
  ProfileViewModel({
    required ProfileOperation profileOperation,
    required ProductViewModel productViewModel,
    required EntryOperation entryOperation,
  })  : _profileOperation = profileOperation,
        _productViewModel = productViewModel,
        _entryOperation = entryOperation,
        super(ProfileViewState(isLoading: false));

  late final ProfileOperation _profileOperation;
  late final EntryOperation _entryOperation;
  File? selectedPhoto;
  late final ProductViewModel _productViewModel;

  void _setLoading(bool value) {
    emit(state.copyWith(isLoading: value));
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
  Future<bool> getProfile(int userId) async {
    _setLoading(true);
    final response = await _profileOperation.getProfile(userId);
    emit(state.copyWith(profileModel: response?.profileModel));
    _setLoading(false);
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
    setServiceRespnonse('Başarıyla çıkış yapıldı');
  }

  Future<void> changePassword(String password, String newpassword, String newrepassword, int userId) async {
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
    final updatedEntries = List<EntryModel>.from(state.profileModel?.entries ?? []);
    updatedEntries.removeWhere((entry) => entry.id == id);
    final updatedProfile = state.profileModel?.copyWith(entries: updatedEntries);
    emit(state.copyWith(profileModel: updatedProfile, activeTab: ProfileTabType.entries));
    _setLoading(false);
    setServiceRespnonse(resp?.message);
  }
}
