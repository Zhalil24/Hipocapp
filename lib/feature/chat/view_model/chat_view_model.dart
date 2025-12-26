import 'dart:convert';

import 'package:core/core.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/chat/view_model/state/chat_view_state.dart';
import 'package:hipocapp/product/cache/model/user_cache_model.dart';
import 'package:hipocapp/product/service/interface/entry_operation.dart';
import 'package:hipocapp/product/service/interface/message_operation.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';
import 'package:hipocapp/product/utility/constans/hub_constants/hub_methods.dart';
import 'package:signalr_netcore/hub_connection.dart';

final class ChatViewModel extends BaseCubit<ChatViewState> {
  /// [LastEntryOperation] service
  ChatViewModel({
    required MessageOperation messageOperation,
    required SharedCacheOperation<UserCacheModel> userCacheOperation,
    required HubConnection hubConnection,
    required this.toUserId,
  })  : _messageOperation = messageOperation,
        _hubConnection = hubConnection,
        _userCacheOperation = userCacheOperation,
        super(ChatViewState(
          isLoading: false,
        ));

  final int toUserId;
  late final MessageOperation _messageOperation;
  late final SharedCacheOperation<UserCacheModel> _userCacheOperation;
  late final HubConnection _hubConnection;
  bool get isConnected => _hubConnection.state == HubConnectionState.Connected;

  /// Change loading state
  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  /// Clear service message
  void clearServiceMessage() {
    emit(state.copyWith(serviceResponseMessage: null));
  }

  /// Set service response
  void setServiceRespnonse(String? message) {
    emit(state.copyWith(serviceResponseMessage: message));
  }

  Future<int> _getUserId() async {
    final cachedUser = await _userCacheOperation.get('user_token');
    final userId = cachedUser!.userId;
    final userName = cachedUser.userName;
    emit(state.copyWith(currentUserId: userId, userName: userName));
    return userId;
  }

  /// Get message list from server by user id, and set to state's messageList.
  /// Show loading indicator while fetching data.
  ///
  /// [toUserId] is the id of the user to be fetched.
  Future<void> getMessageList(int toUserId) async {
    changeLoading();
    final fromUserId = await _getUserId();
    final resp = await _messageOperation.getMessageList(fromUserId, toUserId);
    emit(state.copyWith(messageList: resp));

    changeLoading();
  }

  /// Send private message to user.
  ///
  /// [toUserId] is the user id of the recipient.
  /// [messageText] is the text of the message.
  ///
  /// This method invokes the 'SendPrivateMessage' hub method and sends the message to the server.
  /// It also adds the new message to the list of messages in the state.
  /// Then, it calls the [_saveMessage] method to save the message to the local database.
  Future<void> sendPrivateMessage({
    required int toUserId,
    required String messageText,
  }) async {
    final messageDto = {
      'fromUserId': await _getUserId(),
      'toUserId': toUserId,
      'messageText': messageText,
      'sentAt': DateTime.now().toIso8601String(),
      'isRead': false,
    };
    await _hubConnection.invoke(HubMethods.sendPrivateMessage, args: [toUserId, messageDto]);
    final newMessage = MessageListModel(
      fromUserId: await _getUserId(),
      toUserId: toUserId,
      messageText: messageText,
      sentAt: DateTime.now().toIso8601String(),
      isRead: false,
    );
    final updatedList = List<MessageListModel>.from(state.messageList ?? [])..add(newMessage);
    emit(state.copyWith(messageList: updatedList));
    await _saveMessage(newMessage.fromUserId, newMessage.toUserId, newMessage.messageText, newMessage.sentAt, newMessage.isRead);
  }

  /// Start listening for incoming messages from the hub.
  ///
  /// When a private message is received from the hub, this method will add the message
  /// to the state's messageList and emit a new state with the updated messageList.
  ///
  /// When a group message is received from the hub, this method will add the message
  /// to the state's groupMessageList and emit a new state with the updated groupMessageList.
  ///
  /// This method will also listen for the 'ReceiveGroupMessage' method on the hub, which
  /// will add the message to the state's groupMessageList and emit a new state with the
  /// updated groupMessageList.
  void startListeningMessages() {
    _hubConnection
      ..on(HubMethods.receivePrivateMessage, (List<Object?>? args) {
        if (args == null || args.isEmpty) return;
        final data = args.first;
        if (data is Map<String, dynamic>) {
          final encryptedText = data['messageText'] ?? '';
          final fromUserId = data['fromUserId'];
          if (fromUserId == toUserId) {
            final message = MessageListModel.fromJson(data).copyWith(
              messageText: encryptedText.toString(),
              sentAt: (data['sentAt'] ?? '').toString(),
            );
            final updatedList = List<MessageListModel>.from(state.messageList ?? [])..add(message);
            emit(state.copyWith(messageList: updatedList));
          }
        }
      })
      ..on(HubMethods.receiveGroupMessage, (args) {
        if (args == null || args.isEmpty) return;
        final dynamic rawData = args.first;
        final String jsonString = rawData as String;
        final Map<String, dynamic> jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
        jsonMap['sentOn'] ??= DateTime.now().toIso8601String();
        final message = GroupMessageModel.fromJson(jsonMap);
        final updatedList = List<GroupMessageModel>.from(state.groupMessageList ?? [])..add(message);
        emit(state.copyWith(groupMessageList: updatedList));
      });
  }

  Future<void> _saveMessage(int? fromUserId, int? toUserId, String? messageText, String? sentAt, bool? isRead) async {
    final model = MessageModel(
      id: 0,
      fromUserId: fromUserId,
      toUserId: toUserId,
      messageText: messageText,
      isRead: isRead,
      sentAt: sentAt,
    );
    await _messageOperation.saveMesage(model);
  }

  /// Mark messages as read for the given user id.
  ///
  /// This method calls the 'MarkMessage' method of the [_messageOperation] service and
  /// marks the messages as read. The method takes the user id of the recipient as an argument.
  /// The method is usually called when a user is viewing a chat screen.
  ///
  Future<void> markMessage(int toUserId) async {
    final model = MarkMessageModel(
      fromUserId: toUserId,
      toUserId: await _getUserId(),
    );
    await _messageOperation.markMessage(model);
  }

  /// Fetch group messages from the server for the specified group id and update the state's groupMessageList.
  ///
  /// This method fetches messages associated with the given [groupId] from the server
  /// using the [_messageOperation] service. Once the messages are fetched, it updates
  /// the state's [groupMessageList] with the retrieved messages.
  ///
  /// [groupId] - The id of the group whose messages are to be fetched.

  Future<void> getGroupMessage(int groupId) async {
    await _getUserId();
    final resp = await _messageOperation.getGroupMessage(groupId);
    emit(state.copyWith(groupMessageList: resp));
  }

  /// Send a message to a group.
  ///
  /// This method constructs a `GroupMessageModel` using the provided parameters
  /// and the current user's ID and username. It then invokes the `sendGroupMessage`
  /// method on the hub to send the message to the specified group. The message is
  /// also added to the state's `groupMessageList`, and it is saved using the
  /// message operation service.
  ///
  /// [groupName] - The name of the group to which the message is being sent.
  /// [message] - The content of the message to be sent.
  /// [groupId] - The unique identifier of the group.

  Future<void> sendMessageGroup({
    required String groupName,
    required String message,
    required int groupId,
  }) async {
    await _getUserId();
    final model = GroupMessageModel(
      fromUserId: state.currentUserId,
      messageText: message,
      groupId: groupId,
      fromUserName: state.userName,
      sentOn: DateTime.now().toIso8601String(),
    );
    final jsonString = jsonEncode(model.toJson());
    await _hubConnection.invoke(HubMethods.sendGroupMessage, args: [groupName, jsonString]);
    await _messageOperation.groupMessageSave(model);
  }

  /// Leave a SignalR group.
  ///
  /// This method sends a request to the SignalR hub to leave the specified group.
  /// It toggles the loading state before and after the request to indicate the
  /// operation is in progress.
  ///
  /// [groupName] - The name of the group to leave.

  Future<void> leaveGroup(String groupName) async {
    changeLoading();
    await _hubConnection.invoke(HubMethods.leaveGroup, args: [groupName]);
    changeLoading();
  }
}
