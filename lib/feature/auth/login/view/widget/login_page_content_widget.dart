import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import 'login_background_widget.dart';
import 'login_form_widget.dart';
import 'login_hero_panel_widget.dart';

class LoginPageContentWidget extends StatelessWidget {
  const LoginPageContentWidget({
    super.key,
    required this.isLoading,
    required this.userNameController,
    required this.passwordController,
    required this.onLogin,
  });

  final bool isLoading;
  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final Future<bool> Function() onLogin;

  @override
  Widget build(BuildContext context) {
    final low = context.sized.lowValue;
    final normal = context.sized.normalValue;

    return Stack(
      children: [
        const Positioned.fill(child: LoginBackgroundWidget()),
        Positioned.fill(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 900;
              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  normal + (low * 0.5),
                  normal * 1.5,
                  normal + (low * 0.5),
                  normal * 1.5,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1080),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, (normal * 1.5) * (1 - value)),
                            child: child,
                          ),
                        );
                      },
                      child: isWide
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: normal * 1.75),
                                    child: LoginHeroPanelWidget(),
                                  ),
                                ),
                                Expanded(
                                  child: LoginFormWidget(
                                    isLoading: isLoading,
                                    userNameController: userNameController,
                                    passwordController: passwordController,
                                    onLogin: onLogin,
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const LoginHeroPanelWidget(isCompact: true),
                                SizedBox(height: normal + (low * 0.5)),
                                LoginFormWidget(
                                  isLoading: isLoading,
                                  userNameController: userNameController,
                                  passwordController: passwordController,
                                  onLogin: onLogin,
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        if (isLoading)
          const Positioned.fill(
            child: ColoredBox(
              color: Color(0x33000000),
            ),
          ),
      ],
    );
  }
}
