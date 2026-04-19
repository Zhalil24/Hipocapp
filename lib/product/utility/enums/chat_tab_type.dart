import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';

enum ChatTabType {
  following(LocaleKeys.chat_user_list_tab_users, Icons.people_alt_rounded),
  pastMessages(LocaleKeys.chat_user_list_tab_past_messages, Icons.star),
  groups(LocaleKeys.chat_user_list_tab_groups, Icons.group);

  final String labelKey;
  final IconData icon;

  const ChatTabType(this.labelKey, this.icon);

  String get label => labelKey.tr();

  String withQuery(String query) {
    return '$label/$query';
  }
}
