import 'package:flutter/cupertino.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Adapt your view only table and phone
class AdaptMobileView extends StatelessWidget {
  /// Define your custom widget for every platform
  /// Mobile , Tablet
  const AdaptMobileView({
    super.key,
    required this.phone,
    required this.tablet,
  });

  /// Define your custom widget for phone
  final Widget phone;

  /// Define your custom widget for tablet
  final Widget tablet;
  @override
  Widget build(BuildContext context) {
    if (ResponsiveBreakpoints.of(context).isMobile) return phone;
    if (ResponsiveBreakpoints.of(context).isTablet) return tablet;

    return phone;
  }
}
