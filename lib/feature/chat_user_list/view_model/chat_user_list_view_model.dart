import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/chat_user_list/view_model/state/chat_user_list_view_state.dart';
import 'package:hipocapp/product/cache/model/user_cache_model.dart';
import 'package:hipocapp/product/service/interface/follow_operation.dart';
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
    required FollowOperation followOperation,
  })  : _userCacheOperation = userCacheOperation,
        _messageOperation = messageOperation,
        _hubConnection = hubConnection,
        _userOperation = userOperation,
        _followOperation = followOperation,
        super(
          const ChatUserListViewState(
            isLoading: false,
          ),
        );

  late final SharedCacheOperation<UserCacheModel> _userCacheOperation;
  late final UserOperation _userOperation;
  late final MessageOperation _messageOperation;
  late final FollowOperation _followOperation;
  late final HubConnection _hubConnection;
  bool _eventsRegistered = false;
  MethodInvocationFunc? _userConnectedHandler;
  MethodInvocationFunc? _userDisconnectedHandler;

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

  Future<void> changeTabAndLoad(ChatTabType tab) async {
    emit(
      state.copyWith(
        activeTab: tab,
        isLoading: true,
        searchQuery: tab == ChatTabType.following ? state.searchQuery : '',
      ),
    );

    try {
      await connect();
      switch (tab) {
        case ChatTabType.following:
          await _fetchFollowingUsers();
          break;
        case ChatTabType.pastMessages:
          final usersFuture = _fetchConversationUsers();
          await Future.wait([
            getUnReadMessage(),
            getLastMessages(usersFuture: usersFuture),
          ]);
          break;
        case ChatTabType.groups:
          await getGroups();
          break;
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> initialize({
    ChatTabType? initialTab,
    String? initialQuery,
  }) async {
    final normalizedQuery = initialQuery?.trim() ?? '';
    final resolvedTab = initialTab ??
        (normalizedQuery.isNotEmpty ? ChatTabType.following : state.activeTab);

    _setLoading(true);
    emit(
      state.copyWith(
        activeTab: resolvedTab,
        searchQuery: normalizedQuery,
      ),
    );
    late final Future<List<ProfileModel>> followingFuture;
    late final Future<void> unreadFuture;
    late final Future<void> groupsFuture;
    late final Future<List<ProfileModel>> conversationUsersFuture;
    late final Future<void> lastMessagesFuture;
    try {
      await connect();
      followingFuture = _fetchFollowingUsers();
      unreadFuture = getUnReadMessage();
      groupsFuture = getGroups();
      conversationUsersFuture = _fetchConversationUsers();
      lastMessagesFuture = getLastMessages(
        usersFuture: conversationUsersFuture,
      );

      switch (resolvedTab) {
        case ChatTabType.following:
          await followingFuture;
          break;
        case ChatTabType.pastMessages:
          await Future.wait([
            lastMessagesFuture,
            unreadFuture,
          ]);
          break;
        case ChatTabType.groups:
          await groupsFuture;
          break;
      }
    } finally {
      _setLoading(false);
    }

    unawaited(
      Future.wait([
        followingFuture,
        unreadFuture,
        groupsFuture,
        conversationUsersFuture,
        lastMessagesFuture,
      ]),
    );
  }

  Future<int> _getUserId() async {
    final cachedUser = await _userCacheOperation.get('user_token');
    return cachedUser!.userId;
  }

  Future<void> connect() async {
    final userId = await _getUserId();
    if (!isConnected) {
      await _hubConnection.start();
    }
    await _hubConnection.invoke(HubMethods.registerUser, args: [userId]);
    if (!_eventsRegistered) {
      _setupSignalREvents();
      _eventsRegistered = true;
    }
  }

  Future<void> disconnect() async {
    try {
      _removeSignalREvents();
      if (!isConnected) {
        return;
      }
      final userId = await _getUserId();
      await _hubConnection.invoke(
        HubMethods.disconnectUserMobil,
        args: [userId],
      );
      await _hubConnection.stop();
    } catch (error, stackTrace) {
      debugPrint('[CHAT_LIST][SIGNALR][DISCONNECT] $error');
      debugPrint('[CHAT_LIST][SIGNALR][STACK] $stackTrace');
    }
  }

  Future<void> joinGroup(String groupName) async {
    await _hubConnection.invoke(HubMethods.joinGroup, args: [groupName]);
  }

  Future<List<ProfileModel>> _fetchFollowingUsers() async {
    final currentUserId = await _getUserId();
    final response = await _followOperation.getFollowing(currentUserId);
    final onlineUserIds = await _getOnlineUserIds();
    final followUsers = response?.users ?? const <FollowUserItemModel>[];
    final followedIds = followUsers
        .map((item) => item.followingUserId)
        .whereType<int>()
        .where((id) => id != currentUserId)
        .toSet();
    final updatedUsers = await _fetchProfilesByIds(
      followedIds,
      onlineUserIds: onlineUserIds,
      fallbackUsers: followUsers,
      useFollowerFields: false,
    );

    emit(
      state.copyWith(
        profileModel: updatedUsers,
        filteredProfiles: _applyFilter(
          updatedUsers,
          state.searchQuery,
        ),
        lastMessageUsers: _mergeKnownProfiles(
          state.lastMessageUsers,
          updatedUsers,
        ),
      ),
    );
    return updatedUsers;
  }

  Future<List<ProfileModel>> _fetchProfilesByIds(
    Set<int> userIds, {
    required List<int> onlineUserIds,
    List<FollowUserItemModel> fallbackUsers = const <FollowUserItemModel>[],
    required bool useFollowerFields,
  }) async {
    if (userIds.isEmpty) {
      return <ProfileModel>[];
    }

    final profiles = await Future.wait(
      userIds.map((userId) async {
        final fallbackName = _resolveFallbackUserName(
          fallbackUsers,
          userId,
          useFollowerFields: useFollowerFields,
        );
        try {
          final response = await _userOperation.getUserById(userId);
          final profile = response?.profileModel;
          if (profile != null) {
            return profile.copyWith(
              id: profile.id ?? userId,
              username: _resolveDisplayUserName(
                primaryName: profile.username,
                fallbackName: fallbackName,
              ),
              isOnline: onlineUserIds.contains(userId),
            );
          }
        } catch (_) {}

        return ProfileModel(
          id: userId,
          username: _resolveDisplayUserName(
            primaryName: null,
            fallbackName: fallbackName,
          ),
          isOnline: onlineUserIds.contains(userId),
        );
      }),
    );

    profiles.sort(
      (left, right) => (left.username ?? '')
          .toLowerCase()
          .compareTo((right.username ?? '').toLowerCase()),
    );

    return profiles;
  }

  FollowUserItemModel? _findFallbackUser(
    List<FollowUserItemModel> users,
    int userId, {
    required bool useFollowerFields,
  }) {
    for (final user in users) {
      final candidateId =
          useFollowerFields ? user.followerUserId : user.followingUserId;
      if (candidateId == userId) {
        return user;
      }
    }
    return null;
  }

  String? _resolveFallbackUserName(
    List<FollowUserItemModel> users,
    int userId, {
    required bool useFollowerFields,
  }) {
    final fallback = _findFallbackUser(
      users,
      userId,
      useFollowerFields: useFollowerFields,
    );
    return useFollowerFields
        ? fallback?.followerUserName
        : fallback?.followingUserName;
  }

  String _resolveDisplayUserName({
    required String? primaryName,
    required String? fallbackName,
  }) {
    final resolvedPrimary = primaryName?.trim() ?? '';
    if (resolvedPrimary.isNotEmpty) {
      return resolvedPrimary;
    }

    final resolvedFallback = fallbackName?.trim() ?? '';
    return resolvedFallback;
  }

  List<ProfileModel>? _mergeKnownProfiles(
    List<ProfileModel>? currentUsers,
    List<ProfileModel> overlayUsers,
  ) {
    if (currentUsers == null || currentUsers.isEmpty) {
      return currentUsers;
    }

    final overlayMap = <int, ProfileModel>{
      for (final profile in overlayUsers)
        if (profile.id != null) profile.id!: profile,
    };

    return currentUsers.map((profile) {
      final id = profile.id;
      if (id == null) {
        return profile;
      }

      final overlay = overlayMap[id];
      if (overlay == null) {
        return profile;
      }

      return profile.copyWith(
        username: _resolveDisplayUserName(
          primaryName: overlay.username,
          fallbackName: profile.username,
        ),
        photoURL: overlay.photoURL ?? profile.photoURL,
        imageURL: overlay.imageURL ?? profile.imageURL,
        isOnline: overlay.isOnline ?? profile.isOnline,
      );
    }).toList();
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

  Future<List<ProfileModel>> _fetchConversationUsers() async {
    final response = await _userOperation.getAllUsers() ?? <ProfileModel>[];
    final onlineUserIds = await _getOnlineUserIds();
    final currentUserId = await _getUserId();

    return response
        .where((user) => user.id != currentUserId)
        .map(
          (user) => user.copyWith(
            username: _resolveDisplayUserName(
              primaryName: user.username,
              fallbackName: null,
            ),
            isOnline: onlineUserIds.contains(user.id),
          ),
        )
        .toList();
  }

  Future<void> getAllUser() async {
    _setLoading(true);
    try {
      await _fetchFollowingUsers();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getLastMessages({
    List<ProfileModel>? seedProfiles,
    Future<List<ProfileModel>>? usersFuture,
  }) async {
    final userId = await _getUserId();
    final messages = await _messageOperation.getLastMessageFromUserId(userId);
    final users = seedProfiles ??
        (usersFuture != null
            ? await usersFuture
            : await _fetchConversationUsers());
    final recentConversationIds = _extractRecentConversationUserIds(
      messages: messages ?? <MessageModel>[],
      currentUserId: userId,
    );
    final usersById = <int, ProfileModel>{
      for (final profile in users)
        if (profile.id != null) profile.id!: profile,
    };
    final missingUserIds =
        recentConversationIds.where((id) => !usersById.containsKey(id)).toSet();

    if (missingUserIds.isNotEmpty) {
      final missingUsers = await _fetchProfilesByIds(
        missingUserIds,
        onlineUserIds: await _getOnlineUserIds(),
        useFollowerFields: false,
      );
      for (final profile in missingUsers) {
        final id = profile.id;
        if (id != null) {
          usersById[id] = profile;
        }
      }
    }

    final matchedUsers = recentConversationIds
        .map((id) => usersById[id])
        .whereType<ProfileModel>()
        .toList();

    emit(
      state.copyWith(
        lastMessageUsers: matchedUsers,
        messageModel: messages ?? <MessageModel>[],
      ),
    );
  }

  List<int> _extractRecentConversationUserIds({
    required List<MessageModel> messages,
    required int currentUserId,
  }) {
    final orderedIds = <int>[];
    final seenIds = <int>{};

    for (final message in messages) {
      final otherUserId = message.fromUserId == currentUserId
          ? message.toUserId
          : message.fromUserId;
      if (otherUserId == null ||
          otherUserId <= 0 ||
          seenIds.contains(otherUserId)) {
        continue;
      }
      seenIds.add(otherUserId);
      orderedIds.add(otherUserId);
    }

    return orderedIds;
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
    _userConnectedHandler ??= (args) {
      if (args != null && args.isNotEmpty && args.first is int) {
        _markUserOnline(args.first! as int);
      }
    };
    _userDisconnectedHandler ??= (args) {
      if (args != null && args.isNotEmpty && args.first is int) {
        _markUserOffline(args.first! as int);
      }
    };

    _hubConnection.on(
      HubMethods.userConnected,
      _userConnectedHandler!,
    );
    _hubConnection.on(
      HubMethods.userDisconnected,
      _userDisconnectedHandler!,
    );
  }

  void _removeSignalREvents() {
    if (!_eventsRegistered) {
      return;
    }

    if (_userConnectedHandler != null) {
      _hubConnection.off(
        HubMethods.userConnected,
        method: _userConnectedHandler,
      );
    }
    if (_userDisconnectedHandler != null) {
      _hubConnection.off(
        HubMethods.userDisconnected,
        method: _userDisconnectedHandler,
      );
    }

    _eventsRegistered = false;
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
