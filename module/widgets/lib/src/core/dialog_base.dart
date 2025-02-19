import 'package:flutter/material.dart';

final class DialogBase {
  DialogBase._();

  /// Show a dialog with
  /// [builder] for the dialog
  /// [barrierDismissible] is false
  /// [useSafeArea] is false
  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
  }) {
    return showDialog<T>(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      builder: builder,
    );
  }
}
