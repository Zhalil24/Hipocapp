import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/chat_user_list/view/mixin/chat_user_list_view_mixin.dart';
import 'package:hipocapp/feature/chat_user_list/view/widget/group_list_widget.dart';
import 'package:hipocapp/feature/chat_user_list/view/widget/user_list_widget.dart';
import 'package:hipocapp/feature/chat_user_list/view_model/chat_user_list_view_model.dart';
import 'package:hipocapp/feature/chat_user_list/view_model/state/chat_user_list_view_state.dart';
import 'package:hipocapp/product/navigation/app_router.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/utility/enums/chat_tab_type.dart';
import 'package:hipocapp/product/widget/custom_loader/custom_loader_widget.dart';
import 'package:hipocapp/product/widget/tab_buttons/tab_buttons_widget.dart';
import 'package:kartal/kartal.dart';

@RoutePage()
class ChatUserListView extends StatefulWidget {
  const ChatUserListView({super.key, this.tab, this.query});
  final ChatTabType? tab;
  final String? query;
  @override
  State<ChatUserListView> createState() => _ChatUserListViewState();
}

class _ChatUserListViewState extends BaseState<ChatUserListView> with ChatUserListViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => chatUserListViewModel,
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<ChatUserListViewModel, ChatUserListViewState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CustomLoader());
            }

            if (state.profileModel == null || state.profileModel!.isEmpty) {
              return const Center(child: Text('Kullanıcı bulunamadı.'));
            }

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: context.sized.lowValue),
                  child: TabButtonsWidget<ChatTabType>(
                    activeTabIndex: state.activeTab.index,
                    tabs: ChatTabType.values,
                    onTap: (index) => chatUserListViewModel.changeTab(
                      ChatTabType.values[index],
                    ),
                  ),
                ),
                Expanded(
                  child: _buildTabContent(state.activeTab, chatUserListViewModel.state),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTabContent(ChatTabType? tab, ChatUserListViewState state) {
    switch (tab) {
      case ChatTabType.users:
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(context.sized.lowValue),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  chatUserListViewModel.filterProfiles(value);
                },
                decoration: InputDecoration(
                  hintText: 'Kullanıcı ara...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: state.filteredProfiles?.length,
                itemBuilder: (context, index) {
                  final profile = state.filteredProfiles?[index];
                  return Padding(
                    padding: EdgeInsets.all(context.sized.lowValue),
                    child: UserListWidget(
                      username: profile?.username ?? 'Bilinmeyen',
                      photoURL: profile?.photoURL ?? '',
                      isOnline: profile?.isOnline,
                      onTop: () {
                        context.router.push(ChatRoute(
                          isOnline: profile?.isOnline ?? false,
                          toUserId: profile?.id ?? 0,
                          toUserName: profile?.username ?? '',
                        ));
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );

      case ChatTabType.pastMessages:
        return ListView.builder(
          itemCount: state.lastMessageUsers?.length ?? 0,
          itemBuilder: (context, index) {
            final lastMessageUsers = state.lastMessageUsers![index];
            final unreadCount = chatUserListViewModel.getUnReadMessageCount(lastMessageUsers.id ?? 0);

            return UserListWidget(
              unreadMessageCount: unreadCount,
              isOnline: lastMessageUsers.isOnline,
              username: lastMessageUsers.username.toString(),
              photoURL: lastMessageUsers.photoURL ?? '',
              onTop: () {
                context.router.push(ChatRoute(
                  isOnline: lastMessageUsers.isOnline ?? false,
                  toUserId: lastMessageUsers.id ?? 0,
                  toUserName: lastMessageUsers.username ?? '',
                ));
                chatUserListViewModel.clearUnreadMessageCountForUser(lastMessageUsers.id ?? 0);
              },
            );
          },
        );

      case ChatTabType.groups:
        if (state.groups == null) {
          return const Center(child: Text('Grup bulunamadı'));
        }
        return ListView.builder(
          itemCount: state.groups?.length,
          itemBuilder: (context, index) {
            final groups = state.groups?[index];
            return GroupListWidget(
              groupName: groups!.groupName,
              onTop: () async {
                await chatUserListViewModel.joinGroup(groups.groupName ?? '');
                await context.router.push(ChatRoute(
                  groupId: groups.id,
                  groupName: groups.groupName,
                ));
              },
            );
          },
        );

      default:
        return const SizedBox.shrink(); // null veya bilinmeyen durumda
    }
  }
}
