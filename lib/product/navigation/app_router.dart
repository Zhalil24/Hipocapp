import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hipocapp/feature/auth/login/view/login_view.dart';
import 'package:hipocapp/feature/home/view/home_view.dart';
import 'package:hipocapp/feature/splash/view/splah_view.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: AppRouter._replaceRouteName)

/// Project router information class
class AppRouter extends RootStackRouter {
  static const _replaceRouteName = 'View,Route';
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: HomeRoute.page),
      ];
}
