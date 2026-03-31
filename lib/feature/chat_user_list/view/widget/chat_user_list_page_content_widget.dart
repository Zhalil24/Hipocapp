import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/chat_user_list/view/widget/chat_user_list_header_card_widget.dart';
import 'package:hipocapp/feature/chat_user_list/view/widget/chat_user_search_card_widget.dart';
import 'package:hipocapp/feature/chat_user_list/view/widget/group_list_widget.dart';
import 'package:hipocapp/feature/chat_user_list/view/widget/user_list_widget.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/feature/chat_user_list/view_model/state/chat_user_list_view_state.dart';
import 'package:hipocapp/product/utility/enums/chat_tab_type.dart';
import 'package:hipocapp/product/widget/custom_loader/custom_loader_widget.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class ChatUserListPageContentWidget extends StatelessWidget {
  const ChatUserListPageContentWidget({
    super.key,
    required this.state,
    required this.searchController,
    required this.onSearchChanged,
    required this.onTabChanged,
    required this.onUserSelected,
    required this.onRecentChatSelected,
    required this.onGroupSelected,
    required this.unreadCountForUser,
  });

  final ChatUserListViewState state;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<ChatTabType> onTabChanged;
  final Future<void> Function(ProfileModel profile) onUserSelected;
  final Future<void> Function(ProfileModel profile) onRecentChatSelected;
  final Future<void> Function(GroupModel group) onGroupSelected;
  final int Function(int userId) unreadCountForUser;

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;
    final users = state.filteredProfiles ?? <ProfileModel>[];
    final recentUsers = state.lastMessageUsers ?? <ProfileModel>[];
    final groups = state.groups ?? <GroupModel>[];

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            normal * 0.82,
            normal * 0.7,
            normal * 0.82,
            normal * 1.4,
          ),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ChatUserListHeaderCardWidget(
                  usersCount: state.profileModel?.length ?? 0,
                  conversationCount: recentUsers.length,
                  channelCount: groups.length,
                ),
                SizedBox(height: normal),
                AppSurfaceCard(
                  padding: EdgeInsets.all(context.sized.height * 0.022),
                  child: AppSegmentedTabBar<ChatTabType>(
                    items: ChatTabType.values,
                    selectedItem: state.activeTab,
                    labelBuilder: _tabLabel,
                    iconBuilder: _tabIcon,
                    onChanged: onTabChanged,
                  ),
                ),
                if (state.activeTab == ChatTabType.users) ...[
                  SizedBox(height: normal),
                  ChatUserSearchCardWidget(
                    searchController: searchController,
                    searchQuery: state.searchQuery,
                    onChanged: onSearchChanged,
                  ),
                ],
              ],
            ),
          ),
        ),
        _buildContentSliver(
          context: context,
          users: users,
          recentUsers: recentUsers,
          groups: groups,
        ),
      ],
    );
  }

  Widget _buildContentSliver({
    required BuildContext context,
    required List<ProfileModel> users,
    required List<ProfileModel> recentUsers,
    required List<GroupModel> groups,
  }) {
    if (state.isLoading) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(context.sized.normalValue),
            child: AppSurfaceCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CustomLoader(),
                  SizedBox(height: context.sized.normalValue),
                  Text(
                    LocaleKeys.chat_user_list_loading.tr(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    switch (state.activeTab) {
      case ChatTabType.users:
        if (users.isEmpty) {
          return _buildEmptyState(
            context: context,
            icon: Icons.person_search_rounded,
            title: state.searchQuery.isNotEmpty
                ? LocaleKeys.chat_user_list_empty_search_title.tr()
                : LocaleKeys.chat_user_list_empty_users_title.tr(),
            message: state.searchQuery.isNotEmpty
                ? LocaleKeys.chat_user_list_empty_search_message.tr()
                : LocaleKeys.chat_user_list_empty_users_message.tr(),
            actionLabel: state.searchQuery.isNotEmpty
                ? LocaleKeys.general_button_clear_search.tr()
                : null,
            onAction: state.searchQuery.isNotEmpty
                ? () {
                    searchController.clear();
                    onSearchChanged('');
                  }
                : null,
          );
        }
        return SliverPadding(
          padding: EdgeInsets.fromLTRB(
            context.sized.normalValue * 0.82,
            0,
            context.sized.normalValue * 0.82,
            context.sized.normalValue * 1.6,
          ),
          sliver: SliverList.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final profile = users[index];
              return UserListWidget(
                username: profile.username ??
                    LocaleKeys.general_fallback_unknown_user.tr(),
                photoURL: profile.photoURL ?? '',
                isOnline: profile.isOnline,
                onTap: () async {
                  await onUserSelected(profile);
                },
              );
            },
          ),
        );
      case ChatTabType.pastMessages:
        if (recentUsers.isEmpty) {
          return _buildEmptyState(
            context: context,
            icon: Icons.chat_bubble_outline_rounded,
            title: LocaleKeys.chat_user_list_empty_conversations_title.tr(),
            message: LocaleKeys.chat_user_list_empty_conversations_message.tr(),
          );
        }
        return SliverPadding(
          padding: EdgeInsets.fromLTRB(
            context.sized.normalValue * 0.82,
            0,
            context.sized.normalValue * 0.82,
            context.sized.normalValue * 1.6,
          ),
          sliver: SliverList.builder(
            itemCount: recentUsers.length,
            itemBuilder: (context, index) {
              final profile = recentUsers[index];
              final unreadCount = unreadCountForUser(profile.id ?? 0);
              return UserListWidget(
                unreadMessageCount: unreadCount,
                isOnline: profile.isOnline,
                username: profile.username ??
                    LocaleKeys.general_fallback_unknown_user.tr(),
                photoURL: profile.photoURL ?? '',
                onTap: () async {
                  await onRecentChatSelected(profile);
                },
              );
            },
          ),
        );
      case ChatTabType.groups:
        if (groups.isEmpty) {
          return _buildEmptyState(
            context: context,
            icon: Icons.groups_outlined,
            title: LocaleKeys.chat_user_list_empty_groups_title.tr(),
            message: LocaleKeys.chat_user_list_empty_groups_message.tr(),
          );
        }
        return SliverPadding(
          padding: EdgeInsets.fromLTRB(
            context.sized.normalValue * 0.82,
            0,
            context.sized.normalValue * 0.82,
            context.sized.normalValue * 1.6,
          ),
          sliver: SliverList.builder(
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              return GroupListWidget(
                groupName: group.groupName,
                memberCount: group.members?.length,
                onTap: () async {
                  await onGroupSelected(group);
                },
              );
            },
          ),
        );
    }
  }

  Widget _buildEmptyState({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            context.sized.normalValue * 0.82,
            0,
            context.sized.normalValue * 0.82,
            context.sized.normalValue * 1.6,
          ),
          child: AppEmptyStateCard(
            icon: icon,
            title: title,
            message: message,
            actionLabel: actionLabel,
            onAction: onAction,
          ),
        ),
      ),
    );
  }

  String _tabLabel(ChatTabType tab) {
    switch (tab) {
      case ChatTabType.users:
        return LocaleKeys.chat_user_list_tab_users.tr();
      case ChatTabType.pastMessages:
        return LocaleKeys.chat_user_list_tab_past_messages.tr();
      case ChatTabType.groups:
        return LocaleKeys.chat_user_list_tab_groups.tr();
    }
  }

  IconData _tabIcon(ChatTabType tab) {
    switch (tab) {
      case ChatTabType.users:
        return Icons.people_alt_rounded;
      case ChatTabType.pastMessages:
        return Icons.chat_rounded;
      case ChatTabType.groups:
        return Icons.groups_rounded;
    }
  }
}
