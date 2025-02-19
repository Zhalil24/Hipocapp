import 'package:flutter/widgets.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Custom resğopnsice for project
/// [MOBILE] 0 - 450
/// [TABLET] 451 - 800
/// [DESKTOP] 801 - 1920
/// [4K] 1921 - double.infinity
/// [CustomResponsive.build(context, child)]
final class CustomResponsive {
  static Widget build(BuildContext context, Widget? child) {
    /// Naje to ui responsive
    return ResponsiveBreakpoints.builder(
      child: child!,
      breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1920, name: DESKTOP),
        const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
      ],
    );
  }
}
