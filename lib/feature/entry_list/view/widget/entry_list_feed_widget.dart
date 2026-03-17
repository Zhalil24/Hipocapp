import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/product/widget/custom_card_widget/custom_card_widget.dart';
import 'package:hipocapp/product/widget/custom_loader/custom_loader_widget.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class EntryListFeedWidget extends StatelessWidget {
  const EntryListFeedWidget({
    required this.isLoading,
    required this.entries,
    required this.isLoggedIn,
    required this.userId,
    super.key,
  });

  final bool isLoading;
  final List<EntryListModel> entries;
  final bool isLoggedIn;
  final int userId;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = context.sized.height * 0.03;

    if (isLoading) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: CustomLoader(),
        ),
      );
    }

    if (entries.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(context.sized.normalValue),
            child: AppEmptyStateCard(
              icon: Icons.forum_outlined,
              title: 'Henuz entry yok',
              message: isLoggedIn
                  ? 'Bu baslik icin ilk yorumu paylasarak akisi sen '
                      'baslatabilirsin.'
                  : 'Bu baslik henuz bos. Giris yaptiginda ilk yorumu '
                      'sen paylasabilirsin.',
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      sliver: SliverList.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final entry = entries[index];
          return CustomCardWidget(
            isHomeCard: true,
            title: entry.titleName.toString(),
            description: entry.entryDescription.toString(),
            userName: '${entry.userName}',
            date: '${entry.date}',
            userId: userId,
          );
        },
      ),
    );
  }
}
