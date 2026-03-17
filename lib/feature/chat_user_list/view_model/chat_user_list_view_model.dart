import 'package:core/core.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/chat_user_list/view_model/state/chat_user_list_view_state.dart';
import 'package:hipocapp/product/cache/model/user_cache_model.dart';
import 'package:hipocapp/product/service/interface/message_operation.dart';
import 'package:hipocapp/product/service/interface/user_operation.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';
import 'package:hipocapp/product/utility/constans/hub_constants/hub_methods.dart';
import 'package:hipocapp/product/utility/enums/chat_tab_type.dart';
import 'package:signalr_netcore/hub_connection.dart';

final class ChatUserListViewModel extends BaseCubit<ChatUserListViewState> {
  ChatUserListViewModel({
    required SharedCacheOperation<UserCacheModel> userCacheOperation,
    required UserOperation userOperation,
    required HubConnection hubConnection,
    required MessageOperation messageOperation,
  })  : _userCacheOperation = userCacheOperation,
        _messageOperation = messageOperation,
        _hubConnection = hubConnection,
        _userOperation = userOperation,
        super(
          const ChatUserListViewState(
            isLoading: false,
          ),
        );

  late final SharedCacheOperation<UserCacheModel> _userCacheOperation;
  late final UserOperation _userOperation;
  late final MessageOperation _messageOperation;
  late final HubConnection _hubConnection;
  bool _eventsRegistered = false;

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

  void changeTab(ChatTabType tab) {
    if (state.activeTab == tab) {
      return;
    }
    emit(state.copyWith(activeTab: tab));
  }

  Future<void> initialize({
    ChatTabType? initialTab,
    String? initialQuery,
  }) async {
    final normalizedQuery = initialQuery?.trim() ?? '';
    final resolvedTab = initialTab ??
        (normalizedQuery.isNotEmpty ? ChatTabType.users : state.activeTab);

    _setLoading(true);
    emit(state.copyWith(activeTab: resolvedTab));
    try {
      await connect();
      final profiles = await _fetchAllUsers();
      final filteredProfiles = _applyFilter(profiles, normalizedQuery);
      emit(
        state.copyWith(
          filteredProfiles: filteredProfiles,
          searchQuery: normalizedQuery,
        ),
      );
      await getUnReadMessage();
      await getGroups();
      await getLastMessages();
    } finally {
      _setLoading(false);
    }
  }

  Future<int> _getUserId() async {
    final cachedUser = await _userCacheOperation.get('user_token');
    return cachedUser!.userId;
  }

  Future<void> connect() async {
    if (!isConnected) {
      await _hubConnection.start();
    }
    final userId = await _getUserId();
    await _hubConnection.invoke(HubMethods.registerUser, args: [userId]);
    if (!_eventsRegistered) {
      _setupSignalREvents();
      _eventsRegistered = true;
    }
  }

  Future<void> disconnect() async {
    if (!isConnected) {
      return;
    }
    final userId = await _getUserId();
    await _hubConnection.invoke(
      HubMethods.disconnectUserMobil,
      args: [userId],
    );
    await _hubConnection.stop();
  }

  Future<void> joinGroup(String groupName) async {
    await _hubConnection.invoke(HubMethods.joinGroup, args: [groupName]);
  }

  Future<List<ProfileModel>> _fetchAllUsers() async {
    final response = await _userOperation.getAllUsers() ?? <ProfileModel>[];
    final onlineUserIds = await _getOnlineUserIds();
    final currentUserId = await _getUserId();

    final updatedUsers = response
        .where((user) => user.id != currentUserId)
        .map(
          (user) => user.copyWith(
            isOnline: onlineUserIds.contains(user.id),
          ),
        )
        .toList();

    emit(
      state.copyWith(
        profileModel: updatedUsers,
        filteredProfiles: _applyFilter(
          updatedUsers,
          state.searchQuery,
        ),
      ),
    );
    return updatedUsers;
  }

  Future<List<int>> _getOnlineUserIds() async {
    if (!isConnected) {
      return <int>[];
    }
    final result = await _hubConnection.invoke(HubMethods.getOnlineUsers);
    if (result is! List) {
      return <int>[];
    }
    return result.whereType<int>().toList();
  }

  Future<void> getAllUser() async {
    _setLoading(true);
    try {
      await _fetchAllUsers();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getLastMessages() async {
    final userId = await _getUserId();
    final messages = await _messageOperation.getLastMessageFromUserId(userId);
    final users = state.profileModel ?? await _fetchAllUsers();
    final otherUserIds = (messages ?? <MessageModel>[])
        .map((message) {
          return message.fromUserId == userId
              ? message.toUserId
              : message.fromUserId;
        })
        .whereType<int>()
        .toSet();

    final matchedUsers = users.where((user) {
      final id = user.id;
      return id != null && otherUserIds.contains(id);
    }).toList();

    emit(
      state.copyWith(
        lastMessageUsers: matchedUsers,
        messageModel: messages ?? <MessageModel>[],
      ),
    );
  }

  Future<void> getUserById(int userId) async {
    _setLoading(true);
    try {
      await _userOperation.getUserById(userId);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getUnReadMessage() async {
    final response =
        await _messageOperation.getUnReadMessagCount(await _getUserId());
    emit(
      state.copyWith(
        unreadCount: response?.unreadCounts ?? <UnReadMessageModel>[],
      ),
    );
  }

  int getUnReadMessageCount(int otherUserId) {
    final match = state.unreadCount?.firstWhere(
      (item) => item.fromUserId == otherUserId,
      orElse: () => UnReadMessageModel(count: 0, fromUserId: otherUserId),
    );
    return match?.count ?? 0;
  }

  void clearUnreadMessageCountForUser(int userId) {
    final updatedList =
        state.unreadCount?.where((item) => item.fromUserId != userId).toList();
    emit(state.copyWith(unreadCount: updatedList));
  }

  void _markUserOnline(int userId) {
    final updatedProfiles = state.profileModel?.map((user) {
      return user.id == userId ? user.copyWith(isOnline: true) : user;
    }).toList();

    final updatedLastMessages = state.lastMessageUsers?.map((user) {
      return user.id == userId ? user.copyWith(isOnline: true) : user;
    }).toList();

    emit(
      state.copyWith(
        profileModel: updatedProfiles,
        filteredProfiles: _applyFilter(updatedProfiles, state.searchQuery),
        lastMessageUsers: updatedLastMessages,
      ),
    );
  }

  void _markUserOffline(int userId) {
    final updatedProfiles = state.profileModel?.map((user) {
      return user.id == userId ? user.copyWith(isOnline: false) : user;
    }).toList();

    final updatedLastMessages = state.lastMessageUsers?.map((user) {
      return user.id == userId ? user.copyWith(isOnline: false) : user;
    }).toList();

    emit(
      state.copyWith(
        profileModel: updatedProfiles,
        filteredProfiles: _applyFilter(updatedProfiles, state.searchQuery),
        lastMessageUsers: updatedLastMessages,
      ),
    );
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

  Future<void> getGroups() async {
    final response = await _messageOperation.getGroups(await _getUserId());
    emit(
      state.copyWith(
        groups: response?.group ?? <GroupModel>[],
      ),
    );
  }

  void setProfiles() {
    emit(
      state.copyWith(
        filteredProfiles: state.profileModel,
        searchQuery: '',
      ),
    );
  }

  void filterProfiles(String query) {
    emit(
      state.copyWith(
        filteredProfiles: _applyFilter(state.profileModel, query),
        searchQuery: query,
      ),
    );
  }

  List<ProfileModel> _applyFilter(
    List<ProfileModel>? profiles,
    String query,
  ) {
    final normalizedQuery = query.trim().toLowerCase();
    final source = profiles ?? <ProfileModel>[];
    if (normalizedQuery.isEmpty) {
      return source;
    }
    return source.where((profile) {
      final name = profile.username?.toLowerCase() ?? '';
      return name.contains(normalizedQuery);
    }).toList();
  }
}
