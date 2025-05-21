import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';

final class ChatViewState extends Equatable {
  ChatViewState({required this.isLoading, this.serviceResponseMessage, this.messageList, this.currentUserId, this.groupMessageList, this.userName});

  final bool isLoading;
  final String? serviceResponseMessage;
  final List<MessageListModel>? messageList;
  final List<GroupMessageModel>? groupMessageList;
  final int? currentUserId;
  final String? userName;

  @override
  List<Object?> get props => [isLoading, serviceResponseMessage, messageList, currentUserId, groupMessageList, userName];

  ChatViewState copyWith({
    bool? isLoading,
    String? serviceResponseMessage,
    List<MessageListModel>? messageList,
    List<GroupMessageModel>? groupMessageList,
    int? currentUserId,
    String? userName,
  }) {
    return ChatViewState(
      isLoading: isLoading ?? this.isLoading,
      serviceResponseMessage: serviceResponseMessage ?? this.serviceResponseMessage,
      messageList: messageList ?? this.messageList,
      currentUserId: currentUserId ?? this.currentUserId,
      groupMessageList: groupMessageList ?? this.groupMessageList,
      userName: userName ?? this.userName,
    );
  }
}
