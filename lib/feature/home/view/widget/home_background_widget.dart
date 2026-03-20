import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class HomeBackgroundWidget extends StatelessWidget {
  const HomeBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    const baseWhite = Colors.white;
    final topOverlayColor = isDark ? baseWhite.withValues(alpha: 0.05) : baseWhite.withValues(alpha: 0.35);

    final middleOverlayColor = isDark ? baseWhite.withValues(alpha: 0.15) : baseWhite.withValues(alpha: 0.60);

    final bottomOverlayColor = isDark ? baseWhite.withValues(alpha: 0.30) : baseWhite.withValues(alpha: 1.0);

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
              stops: const [0.0, 0.4, 1.0],
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
                    baseWhite.withValues(alpha: isDark ? 0.04 : 0.08),
                    baseWhite.withValues(alpha: 0),
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
