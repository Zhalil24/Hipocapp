import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/feature/group_list/view/widget/group_list_group_card_widget.dart';
import 'package:hipocapp/feature/group_list/view/widget/group_list_header_card_widget.dart';
import 'package:hipocapp/feature/group_list/view/widget/skeleton_card_widget.dart';
import 'package:hipocapp/feature/group_list/view_model/state/group_list_view_state.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class GroupListPageContentWidget extends StatelessWidget {
  const GroupListPageContentWidget({
    required this.state,
    required this.isLoggedIn,
    required this.onRefresh,
    required this.onJoinGroup,
    super.key,
  });

  final GroupListViewState state;
  final bool isLoggedIn;
  final Future<void> Function() onRefresh;
  final Future<void> Function(int groupId) onJoinGroup;

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;
    final groups = state.groupListModel;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
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
                  GroupListHeaderCardWidget(
                    groupCount: groups.length,
                    isLoggedIn: isLoggedIn,
                  ),
                  SizedBox(height: normal),
                  Row(
                    children: [
                      Text(
                        LocaleKeys.group_list_section_title.tr(),
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
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(
                            context.sized.height,
                          ),
                        ),
                        child: Text(
                          state.isLoading
                              ? LocaleKeys.group_list_section_loading.tr()
                              : LocaleKeys.general_count_channel.tr(
                                  namedArgs: {'count': '${groups.length}'},
                                ),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                      const Spacer(),
                      if (!state.isLoading)
                        IconButton.outlined(
                          onPressed: () async {
                            await onRefresh();
                          },
                          icon: const Icon(Icons.refresh_rounded),
                          tooltip: LocaleKeys.group_list_refresh_tooltip.tr(),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (state.isLoading)
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                normal,
                0,
                normal,
                normal * 1.4,
              ),
              sliver: SliverList.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const SkeletonCardWidget();
                },
              ),
            ),
          if (!state.isLoading && groups.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    normal,
                    0,
                    normal,
                    normal * 1.4,
                  ),
                  child: AppEmptyStateCard(
                    icon: Icons.forum_outlined,
                    title: LocaleKeys.group_list_empty_title.tr(),
                    message: LocaleKeys.group_list_empty_message.tr(),
                    actionLabel: LocaleKeys.general_button_retry.tr(),
                    onAction: () async {
                      await onRefresh();
                    },
                  ),
                ),
              ),
            ),
          if (!state.isLoading && groups.isNotEmpty)
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                normal,
                0,
                normal,
                normal * 1.4,
              ),
              sliver: SliverList.builder(
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  return GroupListGroupCardWidget(
                    group: groups[index],
                    isLoggedIn: isLoggedIn,
                    onJoinGroup: onJoinGroup,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
