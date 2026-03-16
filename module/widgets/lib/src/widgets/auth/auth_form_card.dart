import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AuthFormCard extends StatelessWidget {
  const AuthFormCard({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;
    final resolvedPadding = padding ?? EdgeInsets.all(context.sized.height * 0.035);

    return Container(
      padding: resolvedPadding,
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: isDark ? 0.90 : 0.94),
        borderRadius: BorderRadius.circular(normal * 2),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.22),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: isDark ? 0.22 : 0.08),
            blurRadius: context.sized.height * 0.035,
            offset: Offset(0, normal + (low * 0.5)),
          ),
        ],
      ),
      child: child,
    );
  }
}
