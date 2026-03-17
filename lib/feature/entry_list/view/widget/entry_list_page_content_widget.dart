import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/entry_list/view/widget/entry_list_composer_widget.dart';
import 'package:hipocapp/feature/entry_list/view/widget/entry_list_feed_widget.dart';
import 'package:hipocapp/feature/entry_list/view/widget/entry_list_header_card_widget.dart';
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
    final low = context.sized.lowValue;
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
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              normal,
              normal * 0.65,
              normal,
              low,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EntryListHeaderCardWidget(
                    titleName: titleName,
                    entryCount: entries.length,
                    isLoggedIn: isLoggedIn,
                  ),
                  if (isLoggedIn) ...[
                    SizedBox(height: normal),
                    EntryListComposerWidget(
                      formKey: formKey,
                      controller: entryController,
                      focusNode: entryFocusNode,
                      onSubmit: onSubmitEntry,
                    ),
                  ],
                  SizedBox(height: normal),
                  Row(
                    children: [
                      Text(
                        'Entry akisi',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                      ),
                      SizedBox(width: low * 0.8),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: low,
                          vertical: low * 0.65,
                        ),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.primary.withValues(
                                    alpha: 0.10,
                                  ),
                          borderRadius: BorderRadius.circular(
                            context.sized.height,
                          ),
                        ),
                        child: Text(
                          '${entries.length} kayit',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
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
