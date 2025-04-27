// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [EntryListView]
class EntryListRoute extends PageRouteInfo<EntryListRouteArgs> {
  EntryListRoute({
    Key? key,
    required String titleName,
    List<PageRouteInfo>? children,
  }) : super(
          EntryListRoute.name,
          args: EntryListRouteArgs(
            key: key,
            titleName: titleName,
          ),
          initialChildren: children,
        );

  static const String name = 'EntryListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EntryListRouteArgs>();
      return EntryListView(
        key: args.key,
        titleName: args.titleName,
      );
    },
  );
}

class EntryListRouteArgs {
  const EntryListRouteArgs({
    this.key,
    required this.titleName,
  });

  final Key? key;

  final String titleName;

  @override
  String toString() {
    return 'EntryListRouteArgs{key: $key, titleName: $titleName}';
  }
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeView();
    },
  );
}

/// generated route for
/// [LoginView]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginView();
    },
  );
}

/// generated route for
/// [SplashView]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashView();
    },
  );
}
