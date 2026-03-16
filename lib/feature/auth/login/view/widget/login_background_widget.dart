import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class LoginBackgroundWidget extends StatelessWidget {
  const LoginBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final height = context.sized.height;
    final width = context.sized.width;
    final largeOrbSize = height * 0.30;
    final mediumOrbSize = height * 0.275;
    final smallOrbSize = height * 0.25;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.surface,
            colorScheme.primary.withValues(alpha: isDark ? 0.16 : 0.08),
            colorScheme.secondary.withValues(alpha: isDark ? 0.12 : 0.06),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -(height * 0.12),
            left: -(width * 0.08),
            child: _GlowOrb(
              color: colorScheme.primary.withValues(alpha: isDark ? 0.20 : 0.16),
              size: largeOrbSize,
            ),
          ),
          Positioned(
            top: height * 0.14,
            right: -(width * 0.12),
            child: _GlowOrb(
              color: colorScheme.secondary.withValues(alpha: isDark ? 0.18 : 0.12),
              size: mediumOrbSize,
            ),
          ),
          Positioned(
            bottom: -(height * 0.10),
            left: width * 0.08,
            child: _GlowOrb(
              color: colorScheme.tertiary.withValues(alpha: isDark ? 0.14 : 0.10),
              size: smallOrbSize,
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({
    required this.color,
    required this.size,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: size * 0.45,
              spreadRadius: size * 0.08,
            ),
          ],
        ),
      ),
    );
  }
}
