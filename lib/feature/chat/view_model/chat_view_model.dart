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
    required HiveCacheOperation<UserCacheModel> userCacheOperation,
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
  late final HiveCacheOperation<UserCacheModel> _userCacheOperation;
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

  int _getUserId() {
    final cachedUser = _userCacheOperation.get('user_token');
    final userId = cachedUser!.userId;
    emit(state.copyWith(currentUserId: userId));
    return userId;
  }

  /// Get message list from server by user id, and set to state's messageList.
  /// Show loading indicator while fetching data.
  ///
  /// [toUserId] is the id of the user to be fetched.
  Future<void> getMessageList(int toUserId) async {
    changeLoading();
    final fromUserId = _getUserId();
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
      'fromUserId': _getUserId(),
      'toUserId': toUserId,
      'messageText': messageText,
      'sentAt': DateTime.now().toIso8601String(),
      'isRead': false,
    };
    await _hubConnection.invoke(HubMethods.sendPrivateMessage, args: [toUserId, messageDto]);
    final newMessage = MessageListModel(
      fromUserId: _getUserId(),
      toUserId: toUserId,
      messageText: messageText,
      sentAt: DateTime.now().toIso8601String(),
      isRead: false,
    );
    final updatedList = List<MessageListModel>.from(state.messageList ?? [])..add(newMessage);
    emit(state.copyWith(messageList: updatedList));
    await _saveMessage(newMessage.fromUserId, newMessage.toUserId, newMessage.messageText, newMessage.sentAt, newMessage.isRead);
  }

  /// Listen to 'ReceivePrivateMessage' event from the hub and update the state's messageList when a new message is received.
  /// The message is decrypted before adding it to the list of messages.
  /// The method is usually called when the view is initialized.
  void startListeningMessages() {
    _hubConnection.on(HubMethods.receivePrivateMessage, (List<Object?>? args) {
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
      toUserId: _getUserId(),
    );
    await _messageOperation.markMessage(model);
  }
}
