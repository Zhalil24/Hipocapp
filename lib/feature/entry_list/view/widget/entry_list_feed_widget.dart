import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/product/widget/custom_card_widget/custom_card_skeleton_widget.dart';
import 'package:hipocapp/product/widget/custom_card_widget/custom_card_widget.dart';
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
      return SliverPadding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        sliver: SliverList.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return const CustomCardWidgetSkeleton();
          },
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
              title: LocaleKeys.entry_list_empty_title.tr(),
              message: isLoggedIn
                  ? LocaleKeys.entry_list_empty_message_logged_in.tr()
                  : LocaleKeys.entry_list_empty_message_logged_out.tr(),
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
            userName: entry.userName,
            date: entry.date ?? '',
            userId: entry.userId,
          );
        },
      ),
    );
  }
}
