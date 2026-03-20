import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class ChatBackgroundWidget extends StatelessWidget {
  const ChatBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Stack(
      fit: StackFit.expand,
      children: [
        const AppAmbientBackground(
          style: AppAmbientBackgroundStyle.profile,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colorScheme.surface.withValues(alpha: isDark ? 0.06 : 0.14),
                colorScheme.surface.withValues(alpha: isDark ? 0.16 : 0.44),
                colorScheme.surface.withValues(alpha: isDark ? 0.90 : 0.98),
              ],
            ),
          ),
        ),
        Positioned(
          top: context.sized.height * 0.10,
          left: -(context.sized.width * 0.12),
          child: IgnorePointer(
            child: Container(
              width: context.sized.width * 0.38,
              height: context.sized.height * 0.12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(context.sized.height),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: isDark ? 0.04 : 0.12),
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
