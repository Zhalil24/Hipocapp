import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class EntryListBackgroundWidget extends StatelessWidget {
  const EntryListBackgroundWidget({super.key});

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
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colorScheme.surface.withValues(alpha: isDark ? 0.04 : 0.08),
                Colors.transparent,
                colorScheme.surface.withValues(alpha: isDark ? 0.20 : 0.90),
              ],
            ),
          ),
        ),
        Positioned(
          top: context.sized.height * 0.09,
          right: context.sized.width * 0.12,
          child: IgnorePointer(
            child: Container(
              width: context.sized.width * 0.28,
              height: context.sized.height * 0.09,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(context.sized.height),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: isDark ? 0.05 : 0.12),
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
