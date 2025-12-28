import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/feature/introduction/view/introduction_view.dart';
import 'package:hipocapp/product/navigation/app_router.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:introduction_screen/introduction_screen.dart';

mixin IntroductionMixin on BaseState<IntroductionView> {
  final String backgroundImage = 'assets/images/file.png';

  final introKey = GlobalKey<IntroductionScreenState>();

  /// Called when the introduction screen has finished.
  /// Replaces the current route with the home route.
  void onIntroEnd(BuildContext context) {
    context.router.replace(const HomeRoute());
  }
}
