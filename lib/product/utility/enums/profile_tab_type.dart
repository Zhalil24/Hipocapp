import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';

enum ProfileTabType {
  profile(LocaleKeys.auth_profile_tab_profile, Icons.person),
  editProfile(LocaleKeys.auth_profile_tab_edit_profile, Icons.account_circle),
  changePassword(
    LocaleKeys.auth_profile_tab_change_password,
    Icons.vpn_key,
  ),
  entries(LocaleKeys.auth_profile_tab_entries, Icons.library_books);

  final String labelKey;
  final IconData icon;

  const ProfileTabType(this.labelKey, this.icon);

  String get label => labelKey.tr();

  String withQuery(String query) {
    return '$label/$query';
  }
}
