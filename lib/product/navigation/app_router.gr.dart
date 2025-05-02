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
    required int headerId,
    List<PageRouteInfo>? children,
  }) : super(
          EntryListRoute.name,
          args: EntryListRouteArgs(
            key: key,
            titleName: titleName,
            headerId: headerId,
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
        headerId: args.headerId,
      );
    },
  );
}

class EntryListRouteArgs {
  const EntryListRouteArgs({
    this.key,
    required this.titleName,
    required this.headerId,
  });

  final Key? key;

  final String titleName;

  final int headerId;

  @override
  String toString() {
    return 'EntryListRouteArgs{key: $key, titleName: $titleName, headerId: $headerId}';
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
/// [ProfilView]
class ProfilRoute extends PageRouteInfo<void> {
  const ProfilRoute({List<PageRouteInfo>? children})
      : super(
          ProfilRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfilRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfilView();
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
