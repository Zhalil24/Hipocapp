import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/product/utility/enums/chat_tab_type.dart';

final class ChatUserListViewState extends Equatable {
  ChatUserListViewState(
      {required this.isLoading,
      this.activeTab = ChatTabType.pastMessages,
      this.serviceResponseMessage,
      this.profileModel,
      this.messageModel,
      this.lastMessageUsers,
      this.groups,
      this.filteredProfiles,
      this.unreadCount});

  final bool isLoading;
  final String? serviceResponseMessage;
  final List<ProfileModel>? profileModel;
  final List<MessageModel>? messageModel;
  final List<ProfileModel>? filteredProfiles;
  final ChatTabType activeTab;
  final List<ProfileModel>? lastMessageUsers;
  final List<UnReadMessageModel>? unreadCount;
  final List<GroupModel>? groups;

  @override
  List<Object?> get props => [
        isLoading,
        serviceResponseMessage,
        profileModel,
        activeTab,
        messageModel,
        lastMessageUsers,
        filteredProfiles,
        unreadCount,
        groups,
      ];

  ChatUserListViewState copyWith(
      {bool? isLoading,
      List<MessageModel>? messageModel,
      List<ProfileModel>? profileModel,
      String? serviceResponseMessage,
      ChatTabType? activeTab,
      List<ProfileModel>? lastMessageUsers,
      List<UnReadMessageModel>? unreadCount,
      List<ProfileModel>? filteredProfiles,
      List<GroupModel>? groups}) {
    return ChatUserListViewState(
      isLoading: isLoading ?? this.isLoading,
      serviceResponseMessage: serviceResponseMessage ?? this.serviceResponseMessage,
      profileModel: profileModel ?? this.profileModel,
      activeTab: activeTab ?? this.activeTab,
      messageModel: messageModel ?? this.messageModel,
      unreadCount: unreadCount ?? this.unreadCount,
      lastMessageUsers: lastMessageUsers ?? this.lastMessageUsers,
      filteredProfiles: filteredProfiles ?? this.filteredProfiles,
      groups: groups ?? this.groups,
    );
  }
}
