import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

enum AppAmbientBackgroundStyle {
  login,
  register,
  profile,
  home,
  groupList,
  splash,
}

class AppAmbientBackground extends StatelessWidget {
  const AppAmbientBackground({
    super.key,
    this.style = AppAmbientBackgroundStyle.login,
  });

  final AppAmbientBackgroundStyle style;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final height = context.sized.height;
    final width = context.sized.width;
    final config = _AmbientBackgroundConfig.resolve(
      style: style,
      colorScheme: colorScheme,
      isDark: isDark,
      height: height,
      width: width,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: config.begin,
          end: config.end,
          colors: config.gradientColors,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          for (final orb in config.orbs)
            Positioned(
              top: orb.top,
              left: orb.left,
              right: orb.right,
              bottom: orb.bottom,
              child: _GlowOrb(
                color: orb.color,
                size: orb.size,
                showShadow: orb.showShadow,
              ),
            ),
          if (config.showSheen)
            Align(
              alignment: const Alignment(0, -0.65),
              child: IgnorePointer(
                child: Container(
                  width: width * 0.52,
                  height: height * 0.18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(height),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(alpha: isDark ? 0.06 : 0.12),
                        Colors.white.withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AmbientBackgroundConfig {
  const _AmbientBackgroundConfig({
    required this.begin,
    required this.end,
    required this.gradientColors,
    required this.orbs,
    required this.showSheen,
  });

  factory _AmbientBackgroundConfig.resolve({
    required AppAmbientBackgroundStyle style,
    required ColorScheme colorScheme,
    required bool isDark,
    required double height,
    required double width,
  }) {
    switch (style) {
      case AppAmbientBackgroundStyle.register:
        return _AmbientBackgroundConfig(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          gradientColors: [
            colorScheme.surface,
            colorScheme.secondary.withValues(alpha: isDark ? 0.10 : 0.05),
            colorScheme.primary.withValues(alpha: isDark ? 0.12 : 0.06),
          ],
          orbs: [
            _AmbientOrbConfig(
              size: height * 0.28,
              color:
                  colorScheme.secondary.withValues(alpha: isDark ? 0.18 : 0.12),
              top: -(height * 0.10),
              right: -(width * 0.08),
            ),
            _AmbientOrbConfig(
              size: height * 0.24,
              color:
                  colorScheme.primary.withValues(alpha: isDark ? 0.16 : 0.10),
              top: height * 0.18,
              left: -(width * 0.10),
            ),
            _AmbientOrbConfig(
              size: height * 0.22,
              color:
                  colorScheme.tertiary.withValues(alpha: isDark ? 0.12 : 0.08),
              bottom: -(height * 0.08),
              right: width * 0.10,
            ),
          ],
          showSheen: true,
        );
      case AppAmbientBackgroundStyle.profile:
        return _AmbientBackgroundConfig(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          gradientColors: [
            colorScheme.primary.withValues(alpha: isDark ? 0.18 : 0.12),
            colorScheme.surface,
            colorScheme.secondary.withValues(alpha: isDark ? 0.14 : 0.08),
          ],
          orbs: [
            _AmbientOrbConfig(
              size: height * 0.24,
              color:
                  colorScheme.primary.withValues(alpha: isDark ? 0.22 : 0.16),
              top: -(height * 0.08),
              right: -(width * 0.08),
              showShadow: false,
            ),
            _AmbientOrbConfig(
              size: height * 0.20,
              color:
                  colorScheme.tertiary.withValues(alpha: isDark ? 0.18 : 0.10),
              top: height * 0.26,
              left: -(width * 0.12),
              showShadow: false,
            ),
            _AmbientOrbConfig(
              size: height * 0.18,
              color:
                  colorScheme.secondary.withValues(alpha: isDark ? 0.18 : 0.12),
              bottom: -(height * 0.05),
              right: width * 0.18,
              showShadow: false,
            ),
          ],
          showSheen: false,
        );
      case AppAmbientBackgroundStyle.home:
        return _AmbientBackgroundConfig(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          gradientColors: [
            colorScheme.surface,
            colorScheme.primary.withValues(alpha: isDark ? 0.12 : 0.06),
            colorScheme.tertiary.withValues(alpha: isDark ? 0.10 : 0.05),
          ],
          orbs: [
            _AmbientOrbConfig(
              size: height * 0.22,
              color:
                  colorScheme.primary.withValues(alpha: isDark ? 0.18 : 0.10),
              top: -(height * 0.05),
              right: width * 0.14,
            ),
            _AmbientOrbConfig(
              size: height * 0.18,
              color:
                  colorScheme.secondary.withValues(alpha: isDark ? 0.14 : 0.08),
              top: height * 0.32,
              left: -(width * 0.08),
            ),
            _AmbientOrbConfig(
              size: height * 0.16,
              color:
                  colorScheme.tertiary.withValues(alpha: isDark ? 0.14 : 0.08),
              bottom: -(height * 0.04),
              right: width * 0.22,
            ),
          ],
          showSheen: false,
        );
      case AppAmbientBackgroundStyle.groupList:
        return _AmbientBackgroundConfig(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          gradientColors: [
            colorScheme.surface,
            colorScheme.primary.withValues(alpha: isDark ? 0.14 : 0.07),
            colorScheme.secondary.withValues(alpha: isDark ? 0.12 : 0.06),
          ],
          orbs: [
            _AmbientOrbConfig(
              size: height * 0.24,
              color:
                  colorScheme.primary.withValues(alpha: isDark ? 0.18 : 0.12),
              top: -(height * 0.06),
              left: -(width * 0.04),
            ),
            _AmbientOrbConfig(
              size: height * 0.20,
              color:
                  colorScheme.secondary.withValues(alpha: isDark ? 0.16 : 0.10),
              top: height * 0.24,
              right: -(width * 0.08),
            ),
            _AmbientOrbConfig(
              size: height * 0.18,
              color:
                  colorScheme.tertiary.withValues(alpha: isDark ? 0.16 : 0.10),
              bottom: -(height * 0.04),
              left: width * 0.18,
            ),
          ],
          showSheen: true,
        );
      case AppAmbientBackgroundStyle.splash:
        return _AmbientBackgroundConfig(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          gradientColors: [
            colorScheme.surface,
            colorScheme.primary.withValues(alpha: isDark ? 0.18 : 0.10),
            colorScheme.secondary.withValues(alpha: isDark ? 0.16 : 0.08),
          ],
          orbs: [
            _AmbientOrbConfig(
              size: height * 0.34,
              color:
                  colorScheme.primary.withValues(alpha: isDark ? 0.22 : 0.18),
              top: -(height * 0.12),
              left: -(width * 0.10),
            ),
            _AmbientOrbConfig(
              size: height * 0.30,
              color:
                  colorScheme.tertiary.withValues(alpha: isDark ? 0.20 : 0.14),
              top: height * 0.12,
              right: -(width * 0.14),
            ),
            _AmbientOrbConfig(
              size: height * 0.26,
              color:
                  colorScheme.secondary.withValues(alpha: isDark ? 0.18 : 0.12),
              bottom: -(height * 0.10),
              left: width * 0.18,
            ),
          ],
          showSheen: true,
        );
      case AppAmbientBackgroundStyle.login:
        return _AmbientBackgroundConfig(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          gradientColors: [
            colorScheme.surface,
            colorScheme.primary.withValues(alpha: isDark ? 0.16 : 0.08),
            colorScheme.secondary.withValues(alpha: isDark ? 0.12 : 0.06),
          ],
          orbs: [
            _AmbientOrbConfig(
              size: height * 0.30,
              color:
                  colorScheme.primary.withValues(alpha: isDark ? 0.20 : 0.16),
              top: -(height * 0.12),
              left: -(width * 0.08),
            ),
            _AmbientOrbConfig(
              size: height * 0.275,
              color:
                  colorScheme.secondary.withValues(alpha: isDark ? 0.18 : 0.12),
              top: height * 0.14,
              right: -(width * 0.12),
            ),
            _AmbientOrbConfig(
              size: height * 0.25,
              color:
                  colorScheme.tertiary.withValues(alpha: isDark ? 0.14 : 0.10),
              bottom: -(height * 0.10),
              left: width * 0.08,
            ),
          ],
          showSheen: true,
        );
    }
  }

  final Alignment begin;
  final Alignment end;
  final List<Color> gradientColors;
  final List<_AmbientOrbConfig> orbs;
  final bool showSheen;
}

class _AmbientOrbConfig {
  const _AmbientOrbConfig({
    required this.size,
    required this.color,
    this.top,
    this.left,
    this.right,
    this.bottom,
    this.showShadow = true,
  });

  final double size;
  final Color color;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final bool showShadow;
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({
    required this.color,
    required this.size,
    required this.showShadow,
  });

  final Color color;
  final double size;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: showShadow
              ? [
                  BoxShadow(
                    color: color,
                    blurRadius: size * 0.45,
                    spreadRadius: size * 0.08,
                  ),
                ]
              : null,
        ),
      ),
    );
  }
}
