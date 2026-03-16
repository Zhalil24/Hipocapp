import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/my_entries_widget.dart';
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
      return const AppEmptyStateCard(
        icon: Icons.edit_note_rounded,
        title: 'Henuz entry yok',
        message: 'Paylastigin entryler burada listelenecek. Ilk icerigini olusturdugunda bu alan hareketlenecek.',
      );
    }

    return Column(
      children: entries.map((entry) {
        return MyEntriesWidget(
          titleName: entry.titleName ?? 'Baslik bulunamadi',
          desc: entry.description ?? '',
          onPressed: () => onDelete(entry.id ?? 0),
        );
      }).toList(),
    );
  }
}
