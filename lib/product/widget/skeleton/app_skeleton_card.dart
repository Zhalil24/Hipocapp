import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

import 'app_skeleton_shimmer.dart';

class AppSkeletonCard extends StatelessWidget {
  const AppSkeletonCard({
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
    return AppSurfaceCard(
      padding: padding,
      margin: margin,
      child: AppSkeletonShimmer(
        child: child,
      ),
    );
  }
}
