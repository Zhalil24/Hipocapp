import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Stateful Widget mixin to handle loading state
mixin MountedMixin<T extends StatefulWidget> on State<T> {
  /// Manage your mounted state
  Future<void> safeOperation(AsyncCallback callback) async {
    if (!mounted) return;
    await callback.call();
  }
}
