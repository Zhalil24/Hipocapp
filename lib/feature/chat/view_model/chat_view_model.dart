import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/chat/view_model/state/chat_view_state.dart';
import 'package:hipocapp/product/cache/model/user_cache_model.dart';
import 'package:hipocapp/product/service/interface/message_operation.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';
import 'package:hipocapp/product/state/container/product_satate_items.dart';
import 'package:hipocapp/product/utility/constans/hub_constants/hub_methods.dart';
import 'package:signalr_netcore/hub_connection.dart';

final class ChatViewModel extends BaseCubit<ChatViewState> {
  ChatViewModel({
    required MessageOperation messageOperation,
    required SharedCacheOperation<UserCacheModel> userCacheOperation,
    required HubConnection hubConnection,
    required this.toUserId,
    required bool manageSignalRLifecycle,
  })  : _messageOperation = messageOperation,
        _hubConnection = hubConnection,
        _userCacheOperation = userCacheOperation,
        _manageSignalRLifecycle = manageSignalRLifecycle,
        super(
          const ChatViewState(
            isLoading: false,
          ),
        );

  final int toUserId;
  late final MessageOperation _messageOperation;
  late final SharedCacheOperation<UserCacheModel> _userCacheOperation;
  late final HubConnection _hubConnection;
  final bool _manageSignalRLifecycle;
  bool _isListening = false;
  int? _activeGroupId;
  MethodInvocationFunc? _privateMessageHandler;
  MethodInvocationFunc? _groupMessageHandler;

  bool get isConnected => _hubConnection.state == HubConnectionState.Connected;

  void _setLoading(bool value) {
    emit(state.copyWith(isLoading: value));
  }

  void clearServiceMessage() {
    emit(state.copyWith(serviceResponseMessage: null));
  }

  void setServiceRespnonse(String? message) {
    emit(state.copyWith(serviceResponseMessage: message));
  }

  Future<void> initialize({
    int? groupId,
    int? toUserId,
  }) async {
    _setLoading(true);
    try {
      await _getUserId();
      _activeGroupId = groupId;
      await _ensureConnection();
      startListeningMessages();
      if (groupId != null) {
        await getGroupMessage(groupId);
      } else {
        final userId = toUserId ?? this.toUserId;
        await getMessageList(userId);
        await markMessage(userId);
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _ensureConnection() async {
    if (!isConnected) {
      await _hubConnection.start();
    }
  }

  Future<int> _getUserId() async {
    final cachedUser = await _userCacheOperation.get('user_token');
    final userId = cachedUser!.userId;
    final userName = cachedUser.userName;
    emit(state.copyWith(currentUserId: userId, userName: userName));
    return userId;
  }

  Future<void> getMessageList(int toUserId) async {
    final fromUserId = await _getUserId();
    final response =
        await _messageOperation.getMessageList(fromUserId, toUserId);
    final normalizedMessages = response
        .map(
          (message) => _withVisiblePrivateMessageTime(
            message,
            currentUserId: fromUserId,
          ),
        )
        .toList();
    emit(state.copyWith(messageList: normalizedMessages));
  }

  Future<void> sendPrivateMessage({
    required int toUserId,
    required String messageText,
  }) async {
    await _getUserId();
    // The server saves the message before delivering it and answers with the saved copy.
    final saved = await _hubConnection.invoke(
      HubMethods.sendPrivateMessage,
      args: [toUserId, messageText],
    );
    if (saved is! Map<String, dynamic>) {
      return;
    }

    final updatedList = List<MessageListModel>.from(state.messageList ?? [])
      ..add(MessageListModel.fromJson(saved));
    emit(state.copyWith(messageList: updatedList));
  }

  void startListeningMessages() {
    if (_isListening) {
      return;
    }
    _isListening = true;

    _privateMessageHandler ??= (List<Object?>? args) {
      if (args == null || args.isEmpty) {
        return;
      }
      final data = args.first;
      if (data is Map<String, dynamic>) {
        final fromUserId = data['fromUserId'];
        if (fromUserId == toUserId) {
          final message = MessageListModel.fromJson(data).copyWith(
            messageText: (data['messageText'] ?? '').toString(),
          );
          final updatedList = List<MessageListModel>.from(
            state.messageList ?? [],
          )..add(message);
          emit(state.copyWith(messageList: updatedList));
        }
      }
    };

    _groupMessageHandler ??= (List<Object?>? args) {
      if (args == null || args.isEmpty) {
        return;
      }
      final data = args.first;
      if (data is! Map<String, dynamic> || data['groupId'] != _activeGroupId) {
        return;
      }

      final message = GroupMessageModel.fromJson(data);
      final updatedList = List<GroupMessageModel>.from(
        state.groupMessageList ?? [],
      )..add(message);
      emit(state.copyWith(groupMessageList: updatedList));
    };

    _hubConnection.on(
      HubMethods.receivePrivateMessage,
      _privateMessageHandler!,
    );
    _hubConnection.on(
      HubMethods.receiveGroupMessage,
      _groupMessageHandler!,
    );
  }

  Future<void> markMessage(int toUserId) async {
    final model = MarkMessageModel(
      fromUserId: toUserId,
      toUserId: await _getUserId(),
    );
    await _messageOperation.markMessage(model);
  }

  Future<void> getGroupMessage(int groupId) async {
    await _getUserId();
    final response = await _messageOperation.getGroupMessage(groupId);
    emit(state.copyWith(groupMessageList: response ?? <GroupMessageModel>[]));
  }

  Future<void> sendMessageGroup({
    required String message,
    required int groupId,
  }) async {
    // The server saves the message and sends it back to every member, this device included.
    await _hubConnection.invoke(
      HubMethods.sendGroupMessage,
      args: [groupId, message],
    );
  }

  Future<void> disposeLifecycle({
    int? groupId,
  }) async {
    try {
      if (groupId != null) {
        await ProductStateItems.signalRService.leaveGroup(groupId);
      }

      _removeMessageListeners();

      if (!_manageSignalRLifecycle || !isConnected) {
        return;
      }

      await _hubConnection.stop();
    } catch (error, stackTrace) {
      debugPrint('[CHAT][SIGNALR][DISPOSE] $error');
      debugPrint('[CHAT][SIGNALR][STACK] $stackTrace');
    }
  }

  void _removeMessageListeners() {
    if (!_isListening) {
      return;
    }

    if (_privateMessageHandler != null) {
      _hubConnection.off(
        HubMethods.receivePrivateMessage,
        method: _privateMessageHandler,
      );
    }
    if (_groupMessageHandler != null) {
      _hubConnection.off(
        HubMethods.receiveGroupMessage,
        method: _groupMessageHandler,
      );
    }

    _isListening = false;
  }

  MessageListModel _withVisiblePrivateMessageTime(
    MessageListModel message, {
    required int currentUserId,
  }) {
    if (message.fromUserId == currentUserId) {
      return message;
    }

    return message.copyWith(
      sentAt: DateTime.now().toIso8601String(),
    );
  }
}
