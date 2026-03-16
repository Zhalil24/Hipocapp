import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class HomeBackgroundWidget extends StatelessWidget {
  const HomeBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final topOverlayColor = isDark
        ? colorScheme.surface.withValues(alpha: 0.05)
        : Colors.white.withValues(alpha: 0.28);
    final middleOverlayColor = isDark
        ? Colors.transparent
        : Colors.white.withValues(alpha: 0.14);
    final bottomOverlayColor = isDark
        ? colorScheme.surface.withValues(alpha: 0.18)
        : Colors.white.withValues(alpha: 0.92);

    return Stack(
      fit: StackFit.expand,
      children: [
        const AppAmbientBackground(
          style: AppAmbientBackgroundStyle.home,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                topOverlayColor,
                middleOverlayColor,
                bottomOverlayColor,
              ],
            ),
          ),
        ),
        Positioned(
          top: context.sized.height * 0.10,
          left: context.sized.width * 0.16,
          child: IgnorePointer(
            child: Container(
              width: context.sized.width * 0.32,
              height: context.sized.height * 0.10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(context.sized.height),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: isDark ? 0.04 : 0.08),
                    Colors.white.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
