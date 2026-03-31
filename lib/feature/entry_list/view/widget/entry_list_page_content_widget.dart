import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/entry_list/view/widget/entry_list_composer_widget.dart';
import 'package:hipocapp/feature/entry_list/view/widget/entry_list_feed_widget.dart';
import 'package:kartal/kartal.dart';

class EntryListPageContentWidget extends StatelessWidget {
  const EntryListPageContentWidget({
    required this.titleName,
    required this.entries,
    required this.isLoading,
    required this.isLoggedIn,
    required this.userId,
    required this.formKey,
    required this.entryController,
    required this.entryFocusNode,
    required this.onSubmitEntry,
    super.key,
  });

  final String titleName;
  final List<EntryListModel> entries;
  final bool isLoading;
  final bool isLoggedIn;
  final int userId;
  final GlobalKey<FormState> formKey;
  final TextEditingController entryController;
  final FocusNode entryFocusNode;
  final Future<void> Function() onSubmitEntry;

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, normal * (1 - value)),
            child: child,
          ),
        );
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          if (isLoggedIn)
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                normal * 0.82,
                normal * 0.65,
                normal * 0.82,
                normal,
              ),
              sliver: SliverToBoxAdapter(
                child: EntryListComposerWidget(
                  formKey: formKey,
                  controller: entryController,
                  focusNode: entryFocusNode,
                  onSubmit: onSubmitEntry,
                ),
              ),
            ),
          EntryListFeedWidget(
            isLoading: isLoading,
            entries: entries,
            isLoggedIn: isLoggedIn,
            userId: userId,
          ),
        ],
      ),
    );
  }
}
