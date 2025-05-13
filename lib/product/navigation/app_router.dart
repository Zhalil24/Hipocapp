import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:hipocapp/feature/auth/forgot_password/view/forgot_password_view.dart';
import 'package:hipocapp/feature/auth/login/view/login_view.dart';
import 'package:hipocapp/feature/auth/profile/view/profil_view.dart';
import 'package:hipocapp/feature/chat/view/chat_view.dart';
import 'package:hipocapp/feature/chat_user_list/view/chat_user_list_view.dart';
import 'package:hipocapp/feature/entry_list/view/entry_list_view.dart';
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
        AutoRoute(page: EntryListRoute.page),
        AutoRoute(page: ProfilRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: ChatUserListRoute.page),
        AutoRoute(page: ChatRoute.page),
      ];
}
