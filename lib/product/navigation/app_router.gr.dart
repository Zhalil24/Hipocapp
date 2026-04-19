// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [ChatUserListView]
class ChatUserListRoute extends PageRouteInfo<ChatUserListRouteArgs> {
  ChatUserListRoute({
    Key? key,
    ChatTabType? tab,
    String? query,
    List<PageRouteInfo>? children,
  }) : super(
          ChatUserListRoute.name,
          args: ChatUserListRouteArgs(key: key, tab: tab, query: query),
          initialChildren: children,
        );

  static const String name = 'ChatUserListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatUserListRouteArgs>(
        orElse: () => const ChatUserListRouteArgs(),
      );
      return ChatUserListView(key: args.key, tab: args.tab, query: args.query);
    },
  );
}

class ChatUserListRouteArgs {
  const ChatUserListRouteArgs({this.key, this.tab, this.query});

  final Key? key;

  final ChatTabType? tab;

  final String? query;

  @override
  String toString() {
    return 'ChatUserListRouteArgs{key: $key, tab: $tab, query: $query}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChatUserListRouteArgs) return false;
    return key == other.key && tab == other.tab && query == other.query;
  }

  @override
  int get hashCode => key.hashCode ^ tab.hashCode ^ query.hashCode;
}

/// generated route for
/// [ChatView]
class ChatRoute extends PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    Key? key,
    int? toUserId,
    String? toUserName,
    bool? isOnline,
    int? groupId,
    String? groupName,
    bool manageSignalRLifecycle = true,
    List<PageRouteInfo>? children,
  }) : super(
          ChatRoute.name,
          args: ChatRouteArgs(
            key: key,
            toUserId: toUserId,
            toUserName: toUserName,
            isOnline: isOnline,
            groupId: groupId,
            groupName: groupName,
            manageSignalRLifecycle: manageSignalRLifecycle,
          ),
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatRouteArgs>(
        orElse: () => const ChatRouteArgs(),
      );
      return ChatView(
        key: args.key,
        toUserId: args.toUserId,
        toUserName: args.toUserName,
        isOnline: args.isOnline,
        groupId: args.groupId,
        groupName: args.groupName,
        manageSignalRLifecycle: args.manageSignalRLifecycle,
      );
    },
  );
}

class ChatRouteArgs {
  const ChatRouteArgs({
    this.key,
    this.toUserId,
    this.toUserName,
    this.isOnline,
    this.groupId,
    this.groupName,
    this.manageSignalRLifecycle = true,
  });

  final Key? key;

  final int? toUserId;

  final String? toUserName;

  final bool? isOnline;

  final int? groupId;

  final String? groupName;

  final bool manageSignalRLifecycle;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, toUserId: $toUserId, toUserName: $toUserName, isOnline: $isOnline, groupId: $groupId, groupName: $groupName, manageSignalRLifecycle: $manageSignalRLifecycle}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChatRouteArgs) return false;
    return key == other.key &&
        toUserId == other.toUserId &&
        toUserName == other.toUserName &&
        isOnline == other.isOnline &&
        groupId == other.groupId &&
        groupName == other.groupName &&
        manageSignalRLifecycle == other.manageSignalRLifecycle;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      toUserId.hashCode ^
      toUserName.hashCode ^
      isOnline.hashCode ^
      groupId.hashCode ^
      groupName.hashCode ^
      manageSignalRLifecycle.hashCode;
}

/// generated route for
/// [EntryListView]
class EntryListRoute extends PageRouteInfo<EntryListRouteArgs> {
  EntryListRoute({
    required String titleName,
    required int headerId,
    required int userId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          EntryListRoute.name,
          args: EntryListRouteArgs(
            titleName: titleName,
            headerId: headerId,
            userId: userId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'EntryListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EntryListRouteArgs>();
      return EntryListView(
        titleName: args.titleName,
        headerId: args.headerId,
        userId: args.userId,
        key: args.key,
      );
    },
  );
}

class EntryListRouteArgs {
  const EntryListRouteArgs({
    required this.titleName,
    required this.headerId,
    required this.userId,
    this.key,
  });

  final String titleName;

  final int headerId;

  final int userId;

  final Key? key;

  @override
  String toString() {
    return 'EntryListRouteArgs{titleName: $titleName, headerId: $headerId, userId: $userId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EntryListRouteArgs) return false;
    return titleName == other.titleName &&
        headerId == other.headerId &&
        userId == other.userId &&
        key == other.key;
  }

  @override
  int get hashCode =>
      titleName.hashCode ^ headerId.hashCode ^ userId.hashCode ^ key.hashCode;
}

/// generated route for
/// [ForgotPasswordView]
class ForgotPasswordRoute extends PageRouteInfo<void> {
  const ForgotPasswordRoute({List<PageRouteInfo>? children})
      : super(ForgotPasswordRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ForgotPasswordView();
    },
  );
}

/// generated route for
/// [GroupListView]
class GroupListRoute extends PageRouteInfo<void> {
  const GroupListRoute({List<PageRouteInfo>? children})
      : super(GroupListRoute.name, initialChildren: children);

  static const String name = 'GroupListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const GroupListView();
    },
  );
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeView();
    },
  );
}

/// generated route for
/// [IntroductionView]
class IntroductionRoute extends PageRouteInfo<void> {
  const IntroductionRoute({List<PageRouteInfo>? children})
      : super(IntroductionRoute.name, initialChildren: children);

  static const String name = 'IntroductionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const IntroductionView();
    },
  );
}

/// generated route for
/// [LoginView]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginView();
    },
  );
}

/// generated route for
/// [ProfilView]
class ProfilRoute extends PageRouteInfo<ProfilRouteArgs> {
  ProfilRoute({
    Key? key,
    int? userId,
    String? username,
    List<PageRouteInfo>? children,
  }) : super(
          ProfilRoute.name,
          args: ProfilRouteArgs(key: key, userId: userId, username: username),
          initialChildren: children,
        );

  static const String name = 'ProfilRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfilRouteArgs>(
        orElse: () => const ProfilRouteArgs(),
      );
      return ProfilView(
        key: args.key,
        userId: args.userId,
        username: args.username,
      );
    },
  );
}

class ProfilRouteArgs {
  const ProfilRouteArgs({this.key, this.userId, this.username});

  final Key? key;

  final int? userId;

  final String? username;

  @override
  String toString() {
    return 'ProfilRouteArgs{key: $key, userId: $userId, username: $username}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProfilRouteArgs) return false;
    return key == other.key &&
        userId == other.userId &&
        username == other.username;
  }

  @override
  int get hashCode => key.hashCode ^ userId.hashCode ^ username.hashCode;
}

/// generated route for
/// [RegisterView]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RegisterView();
    },
  );
}

/// generated route for
/// [SplashView]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashView();
    },
  );
}
