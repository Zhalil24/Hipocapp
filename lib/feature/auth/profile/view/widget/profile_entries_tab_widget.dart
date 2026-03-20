import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/my_entries_widget.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:widgets/widgets.dart';

class ProfileEntriesTabWidget extends StatelessWidget {
  const ProfileEntriesTabWidget({
    super.key,
    required this.profileModel,
    required this.onDelete,
  });

  final ProfileModel? profileModel;
  final ValueChanged<int> onDelete;

  @override
  Widget build(BuildContext context) {
    final entries = profileModel?.entries ?? const <EntryModel>[];

    if (entries.isEmpty) {
      return AppEmptyStateCard(
        icon: Icons.edit_note_rounded,
        title: LocaleKeys.auth_profile_entries_empty_title.tr(),
        message: LocaleKeys.auth_profile_entries_empty_message.tr(),
      );
    }

    return Column(
      children: entries.map((entry) {
        return MyEntriesWidget(
          titleName: entry.titleName ??
              LocaleKeys.general_fallback_title_not_found.tr(),
          desc: entry.description ?? '',
          onPressed: () => onDelete(entry.id ?? 0),
        );
      }).toList(),
    );
  }
}
