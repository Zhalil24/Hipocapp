import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/chat_user_list/view/mixin/chat_user_list_view_mixin.dart';
import 'package:hipocapp/feature/chat_user_list/view/widget/chat_user_list_background_widget.dart';
import 'package:hipocapp/feature/chat_user_list/view/widget/chat_user_list_page_content_widget.dart';
import 'package:hipocapp/feature/chat_user_list/view_model/chat_user_list_view_model.dart';
import 'package:hipocapp/feature/chat_user_list/view_model/state/chat_user_list_view_state.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/product/navigation/app_router.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/utility/enums/chat_tab_type.dart';
import 'package:hipocapp/product/widget/appbar/custom_appbar_widget.dart';

@RoutePage()
class ChatUserListView extends StatefulWidget {
  const ChatUserListView({
    super.key,
    this.tab,
    this.query,
  });

  final ChatTabType? tab;
  final String? query;

  @override
  State<ChatUserListView> createState() => _ChatUserListViewState();
}

class _ChatUserListViewState extends BaseState<ChatUserListView>
    with ChatUserListViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => chatUserListViewModel,
      child: Stack(
        children: [
          const Positioned.fill(
            child: ChatUserListBackgroundWidget(),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
              isDrawer: false,
              title: LocaleKeys.chat_user_list_title.tr(),
            ),
            body: BlocBuilder<ChatUserListViewModel, ChatUserListViewState>(
              builder: (context, state) {
                return ChatUserListPageContentWidget(
                  state: state,
                  onTabChanged: _handleTabChanged,
                  onUserSelected: _openDirectChat,
                  onRecentChatSelected: _openRecentChat,
                  onGroupSelected: _openGroupChat,
                  unreadCountForUser:
                      chatUserListViewModel.getUnReadMessageCount,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleTabChanged(ChatTabType tab) {
    unawaited(chatUserListViewModel.changeTabAndLoad(tab));
  }

  Future<void> _openDirectChat(ProfileModel profile) async {
    final targetUserId = profile.id;
    if (targetUserId == null || targetUserId <= 0) {
      return;
    }

    final router = context.router;
    await router.push(
      ChatRoute(
        isOnline: profile.isOnline ?? false,
        toUserId: targetUserId,
        toUserName: profile.username ?? '',
        manageSignalRLifecycle: false,
      ),
    );
  }

  Future<void> _openRecentChat(ProfileModel profile) async {
    final targetUserId = profile.id;
    if (targetUserId == null || targetUserId <= 0) {
      return;
    }

    final router = context.router;
    await router.push(
      ChatRoute(
        isOnline: profile.isOnline ?? false,
        toUserId: targetUserId,
        toUserName: profile.username ?? '',
        manageSignalRLifecycle: false,
      ),
    );
    chatUserListViewModel.clearUnreadMessageCountForUser(targetUserId);
  }

  Future<void> _openGroupChat(GroupModel group) async {
    final router = context.router;
    await chatUserListViewModel.joinGroup(group.groupName ?? '');
    await router.push(
      ChatRoute(
        groupId: group.id,
        groupName: group.groupName,
        manageSignalRLifecycle: false,
      ),
    );
  }
}
