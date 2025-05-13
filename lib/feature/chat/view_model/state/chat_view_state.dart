import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';

final class ChatViewState extends Equatable {
  ChatViewState({required this.isLoading, this.serviceResponseMessage, this.messageList, this.currentUserId});

  final bool isLoading;
  final String? serviceResponseMessage;
  final List<MessageListModel>? messageList;
  final int? currentUserId;

  @override
  List<Object?> get props => [isLoading, serviceResponseMessage, messageList, currentUserId];

  ChatViewState copyWith({
    bool? isLoading,
    String? serviceResponseMessage,
    List<MessageListModel>? messageList,
    int? currentUserId,
  }) {
    return ChatViewState(
      isLoading: isLoading ?? this.isLoading,
      serviceResponseMessage: serviceResponseMessage ?? this.serviceResponseMessage,
      messageList: messageList ?? this.messageList,
      currentUserId: currentUserId ?? this.currentUserId,
    );
  }
}
