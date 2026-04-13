import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppSkeletonShimmer extends StatelessWidget {
  const AppSkeletonShimmer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Shimmer.fromColors(
      baseColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.55),
      highlightColor: colorScheme.surface.withValues(alpha: 0.95),
      child: child,
    );
  }
}
