import 'package:core/core.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/chat_user_list/view_model/state/chat_user_list_view_state.dart';
import 'package:hipocapp/product/cache/model/user_cache_model.dart';
import 'package:hipocapp/product/service/interface/entry_operation.dart';
import 'package:hipocapp/product/service/interface/message_operation.dart';
import 'package:hipocapp/product/service/interface/user_operation.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';
import 'package:hipocapp/product/utility/constans/hub_constants/hub_methods.dart';
import 'package:hipocapp/product/utility/enums/chat_tab_type.dart';
import 'package:signalr_netcore/hub_connection.dart';

final class ChatUserListViewModel extends BaseCubit<ChatUserListViewState> {
  /// [LastEntryOperation] service
  ChatUserListViewModel({
    required HiveCacheOperation<UserCacheModel> userCacheOperation,
    required UserOperation userOperation,
    required HubConnection hubConnection,
    required MessageOperation messageOperation,
  })  : _userCacheOperation = userCacheOperation,
        _messageOperation = messageOperation,
        _hubConnection = hubConnection,
        _userOperation = userOperation,
        super(ChatUserListViewState(
          isLoading: false,
          activeTab: ChatTabType.pastMessages,
        ));

  late final HiveCacheOperation<UserCacheModel> _userCacheOperation;
  late final UserOperation _userOperation;
  late final MessageOperation _messageOperation;
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

  /// Change tab bar
  void changeTab(ChatTabType tab) {
    if (state.activeTab == tab) return;
    changeLoading();
    emit(state.copyWith(activeTab: tab));
    changeLoading();
  }

  int _getUserId() {
    final cachedUser = _userCacheOperation.get('user_token');
    int userId = cachedUser!.userId;
    return userId;
  }

  /// Connect to the SignalR hub and register the user.
  ///
  /// This is a no-op if the hub is already connected.
  ///
  /// After connecting, this will invoke the 'RegisterUser' method on the hub,
  /// passing the user's id as an argument.
  Future<void> connect() async {
    changeLoading();
    if (!isConnected) await _hubConnection.start();
    await _hubConnection.invoke(HubMethods.registerUser, args: [_getUserId()]);
    _setupSignalREvents();
    changeLoading();
  }

  /// Disconnect from the SignalR hub and remove the user's registration from the hub.
  Future<void> disconnect() async {
    changeLoading();
    await _hubConnection.invoke(HubMethods.disconnectUserMobil, args: [_getUserId()]);
    await _hubConnection.stop();
    changeLoading();
  }

  /// Get all users from server, and set to state's profileModel.
  /// Show loading indicator while fetching data.
  // Future<void> getAllUser() async {
  //   changeLoading();
  //   var resp = await _userOperation.getAllUsers();
  //   emit(state.copyWith(profileModel: resp));
  //   changeLoading();
  // }

  Future<void> getAllUser() async {
    changeLoading();
    var resp = await _userOperation.getAllUsers();

    final result = await _hubConnection.invoke(HubMethods.getOnlineUsers);
    final List<int> onlineUserIds = (result as List<dynamic>).map((e) => e as int).toList();

    final updatedUsers = resp?.map((user) {
      return user.copyWith(isOnline: onlineUserIds.contains(user.id));
    }).toList();

    emit(state.copyWith(profileModel: updatedUsers));

    changeLoading();
  }

  /// Fetch all users and last messages from server, and set to state's lastMessageUsers and messageModel.
  /// Show loading indicator while fetching data.
  Future<void> getLastMessages() async {
    await getAllUser();
    changeLoading();
    final userId = _getUserId();
    final messages = await _messageOperation.getLastMessageFromUserId(userId);
    final users = state.profileModel ?? [];

    final otherUserIds = messages!.map((m) {
      return m.fromUserId == userId ? m.toUserId! : m.fromUserId!;
    }).toSet();

    final matchedUsers = users.where((u) {
      final id = u.id;
      return id != null && otherUserIds.contains(id);
    }).toList();

    emit(state.copyWith(
      lastMessageUsers: matchedUsers,
      messageModel: messages,
    ));

    changeLoading();
  }

  /// Get user by id from server, and show loading indicator while fetching data.
  ///
  /// [userId] is the id of the user to be fetched.
  ///
  /// After fetching data, emit a new state with the fetched user added to
  /// state's profileModel.
  ///
  Future<void> getUserById(int userId) async {
    changeLoading();
    await _userOperation.getUserById(userId);
    changeLoading();
  }

  /// Fetch the unread message count for the current user from the server, and
  /// update the state with the fetched data.
  ///
  /// This will fetch the unread message count for the current user, and update
  /// the state's unreadCount with the fetched data. If the fetch fails, the
  /// state will not be updated.
  ///
  /// After fetching data, emit a new state with the fetched unread message count
  /// added to state's unreadCount.
  Future<void> getUnReadMessage() async {
    var resp = await _messageOperation.getUnReadMessagCount(_getUserId());
    emit(state.copyWith(unreadCount: resp?.unreadCounts));
  }

  /// Return the unread message count for the given user id.
  ///
  /// This will search the state's unreadCount list for an entry that matches
  /// the given user id. If such an entry exists, it will return the count
  /// associated with that entry. If no such entry exists, it will return 0.
  int getUnReadMessageCount(int otherUserId) {
    final match = state.unreadCount?.firstWhere(
      (e) => e.fromUserId == otherUserId,
      orElse: () => UnReadMessageModel(count: 0, fromUserId: otherUserId),
    );
    return match?.count ?? 0;
  }

  /// Clear the unread message count for a specific user.
  ///
  /// This method removes the unread message count entry for the given user
  /// id from the state's unreadCount list. After removal, the state is updated
  /// with the modified list.
  ///
  /// [userId] is the id of the user whose unread message count is to be cleared.

  void clearUnreadMessageCountForUser(int userId) {
    final updatedList = state.unreadCount?.where((e) => e.fromUserId != userId).toList();
    emit(state.copyWith(unreadCount: updatedList));
  }

  void _markUserOnline(int userId) {
    final updatedProfiles = state.profileModel?.map((user) {
      return user.id == userId ? user.copyWith(isOnline: true) : user;
    }).toList();

    final updatedLastMessages = state.lastMessageUsers?.map((user) {
      return user.id == userId ? user.copyWith(isOnline: true) : user;
    }).toList();

    emit(state.copyWith(
      profileModel: updatedProfiles,
      lastMessageUsers: updatedLastMessages,
    ));
  }

  void _markUserOffline(int userId) {
    final updatedProfiles = state.profileModel?.map((user) {
      return user.id == userId ? user.copyWith(isOnline: false) : user;
    }).toList();

    final updatedLastMessages = state.lastMessageUsers?.map((user) {
      return user.id == userId ? user.copyWith(isOnline: false) : user;
    }).toList();

    emit(state.copyWith(
      profileModel: updatedProfiles,
      lastMessageUsers: updatedLastMessages,
    ));
  }

  void _setupSignalREvents() {
    _hubConnection
      ..on(HubMethods.userConnected, (args) {
        if (args != null && args.isNotEmpty) {
          final userId = args.first! as int;
          _markUserOnline(userId);
        }
      })
      ..on(HubMethods.userDisconnected, (args) {
        if (args != null && args.isNotEmpty) {
          final userId = args.first! as int;
          _markUserOffline(userId);
        }
      });
  }
}
