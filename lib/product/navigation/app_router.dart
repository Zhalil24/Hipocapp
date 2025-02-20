import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:my_architecture_template/feature/auth/login/view/login_view.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: AppRouter._replaceRouteName)

/// Project router information class
class AppRouter extends RootStackRouter {
  static const _replaceRouteName = 'View,Route';
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
      ];
}
