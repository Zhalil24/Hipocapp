import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class GroupListBackgroundWidget extends StatelessWidget {
  const GroupListBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    const baseWhite = Colors.white;

    return Stack(
      fit: StackFit.expand,
      children: [
        const AppAmbientBackground(
          style: AppAmbientBackgroundStyle.groupList,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0, 0.42, 1],
              colors: [
                baseWhite.withValues(alpha: isDark ? 0.03 : 0.24),
                baseWhite.withValues(alpha: isDark ? 0.10 : 0.50),
                baseWhite.withValues(alpha: isDark ? 0.20 : 0.88),
              ],
            ),
          ),
        ),
        Positioned(
          top: context.sized.height * 0.12,
          right: context.sized.width * 0.12,
          child: IgnorePointer(
            child: Container(
              width: context.sized.width * 0.26,
              height: context.sized.height * 0.10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(context.sized.height),
                gradient: LinearGradient(
                  colors: [
                    baseWhite.withValues(alpha: isDark ? 0.05 : 0.10),
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
