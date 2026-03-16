import 'package:flutter/material.dart';
import 'package:hipocapp/feature/splash/view/widget/splash_brand_panel_widget.dart';
import 'package:hipocapp/feature/splash/view/widget/splash_status_card_widget.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class SplashPageContentWidget extends StatelessWidget {
  const SplashPageContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final low = context.sized.lowValue;
    final normal = context.sized.normalValue;

    return Stack(
      children: [
        const Positioned.fill(
          child: AppAmbientBackground(
            style: AppAmbientBackgroundStyle.splash,
          ),
        ),
        Positioned.fill(
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 920;

                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    normal + (low * 0.5),
                    normal * 1.5,
                    normal + (low * 0.5),
                    normal * 1.5,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1040),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, (normal * 1.4) * (1 - value)),
                              child: child,
                            ),
                          );
                        },
                        child: isWide
                            ? Row(
                                children: [
                                  const Expanded(
                                    child: SplashBrandPanelWidget(),
                                  ),
                                  SizedBox(width: normal * 1.5),
                                  const Expanded(
                                    child: SplashStatusCardWidget(),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SplashBrandPanelWidget(isCompact: true),
                                  SizedBox(height: normal + (low * 0.5)),
                                  const SplashStatusCardWidget(isCompact: true),
                                ],
                              ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
