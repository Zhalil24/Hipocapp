import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class RegisterBackgroundWidget extends StatelessWidget {
  const RegisterBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final height = context.sized.height;
    final width = context.sized.width;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colorScheme.surface,
            colorScheme.secondary.withValues(alpha: isDark ? 0.10 : 0.05),
            colorScheme.primary.withValues(alpha: isDark ? 0.12 : 0.06),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -(height * 0.10),
            right: -(width * 0.08),
            child: _RegisterGlow(
              size: height * 0.28,
              color: colorScheme.secondary.withValues(alpha: isDark ? 0.18 : 0.12),
            ),
          ),
          Positioned(
            top: height * 0.18,
            left: -(width * 0.10),
            child: _RegisterGlow(
              size: height * 0.24,
              color: colorScheme.primary.withValues(alpha: isDark ? 0.16 : 0.10),
            ),
          ),
          Positioned(
            bottom: -(height * 0.08),
            right: width * 0.10,
            child: _RegisterGlow(
              size: height * 0.22,
              color: colorScheme.tertiary.withValues(alpha: isDark ? 0.12 : 0.08),
            ),
          ),
        ],
      ),
    );
  }
}

class _RegisterGlow extends StatelessWidget {
  const _RegisterGlow({
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

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
              spreadRadius: size * 0.06,
            ),
          ],
        ),
      ),
    );
  }
}
