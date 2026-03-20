import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class ChatUserListBackgroundWidget extends StatelessWidget {
  const ChatUserListBackgroundWidget({super.key});

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
                colorScheme.surface.withValues(alpha: isDark ? 0.08 : 0.18),
                colorScheme.surface.withValues(alpha: isDark ? 0.18 : 0.56),
                colorScheme.surface.withValues(alpha: isDark ? 0.84 : 0.96),
              ],
            ),
          ),
        ),
        Positioned(
          top: context.sized.height * 0.08,
          right: -(context.sized.width * 0.12),
          child: IgnorePointer(
            child: Container(
              width: context.sized.width * 0.42,
              height: context.sized.height * 0.12,
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
