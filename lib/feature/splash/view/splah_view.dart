import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/feature/splash/view/mixin/splash_view_mixin.dart';
import 'package:hipocapp/feature/splash/view/widget/splash_page_content_widget.dart';
import 'package:hipocapp/product/state/base/base_state.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends BaseState<SplashView> with SplashViewMixin {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashPageContentWidget(),
    );
  }
}
