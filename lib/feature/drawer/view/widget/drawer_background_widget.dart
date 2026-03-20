import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class DrawerBackgroundWidget extends StatelessWidget {
  const DrawerBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Stack(
      fit: StackFit.expand,
      children: [
        const AppAmbientBackground(
          style: AppAmbientBackgroundStyle.home,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorScheme.surface.withValues(alpha: isDark ? 0.16 : 0.48),
                colorScheme.surface.withValues(alpha: isDark ? 0.10 : 0.22),
                colorScheme.surface.withValues(alpha: isDark ? 0.82 : 0.94),
              ],
            ),
          ),
        ),
        Positioned(
          top: context.sized.height * 0.08,
          left: -(context.sized.width * 0.14),
          child: IgnorePointer(
            child: Container(
              width: context.sized.width * 0.48,
              height: context.sized.height * 0.14,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(context.sized.height),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: isDark ? 0.05 : 0.14),
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
