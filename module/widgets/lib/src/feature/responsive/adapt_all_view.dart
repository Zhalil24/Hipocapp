import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Make a adaptive view for all platforms
class AdaptAllView extends StatelessWidget {
  /// Define your custom widget for every platform
  /// Mobile , Tablet, Desktop
  const AdaptAllView({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  /// Define your custom widget for mobile

  final Widget mobile;

  /// Define your custom widget for tablet

  final Widget tablet;

  /// Define your custom widget for desktop

  final Widget desktop;
  @override
  Widget build(BuildContext context) {
    if (ResponsiveBreakpoints.of(context).isMobile) return mobile;
    if (ResponsiveBreakpoints.of(context).isTablet) return tablet;
    if (ResponsiveBreakpoints.of(context).isDesktop) return desktop;
    return mobile;
  }
}
