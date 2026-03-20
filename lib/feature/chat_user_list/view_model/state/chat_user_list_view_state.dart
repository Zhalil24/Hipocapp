import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/product/utility/enums/chat_tab_type.dart';

final class ChatUserListViewState extends Equatable {
  const ChatUserListViewState({
    required this.isLoading,
    this.activeTab = ChatTabType.pastMessages,
    this.serviceResponseMessage,
    this.profileModel,
    this.messageModel,
    this.lastMessageUsers,
    this.groups,
    this.filteredProfiles,
    this.unreadCount,
    this.searchQuery = '',
  });

  static const Object _sentinel = Object();

  final bool isLoading;
  final String? serviceResponseMessage;
  final List<ProfileModel>? profileModel;
  final List<MessageModel>? messageModel;
  final List<ProfileModel>? filteredProfiles;
  final ChatTabType activeTab;
  final List<ProfileModel>? lastMessageUsers;
  final List<UnReadMessageModel>? unreadCount;
  final List<GroupModel>? groups;
  final String searchQuery;

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
        searchQuery,
      ];

  ChatUserListViewState copyWith({
    bool? isLoading,
    List<MessageModel>? messageModel,
    List<ProfileModel>? profileModel,
    Object? serviceResponseMessage = _sentinel,
    ChatTabType? activeTab,
    List<ProfileModel>? lastMessageUsers,
    List<UnReadMessageModel>? unreadCount,
    List<ProfileModel>? filteredProfiles,
    List<GroupModel>? groups,
    String? searchQuery,
  }) {
    return ChatUserListViewState(
      isLoading: isLoading ?? this.isLoading,
      serviceResponseMessage: identical(serviceResponseMessage, _sentinel)
          ? this.serviceResponseMessage
          : serviceResponseMessage as String?,
      profileModel: profileModel ?? this.profileModel,
      activeTab: activeTab ?? this.activeTab,
      messageModel: messageModel ?? this.messageModel,
      unreadCount: unreadCount ?? this.unreadCount,
      lastMessageUsers: lastMessageUsers ?? this.lastMessageUsers,
      filteredProfiles: filteredProfiles ?? this.filteredProfiles,
      groups: groups ?? this.groups,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
