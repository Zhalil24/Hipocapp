import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AppSurfaceCard extends StatelessWidget {
  const AppSurfaceCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: margin,
      padding: padding ?? EdgeInsets.all(context.sized.height * 0.03),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: isDark ? 0.90 : 0.95),
        borderRadius: BorderRadius.circular(normal * 1.6),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.18),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: isDark ? 0.18 : 0.08),
            blurRadius: context.sized.height * 0.03,
            offset: Offset(0, normal + (low * 0.4)),
          ),
        ],
      ),
      child: child,
    );
  }
}
