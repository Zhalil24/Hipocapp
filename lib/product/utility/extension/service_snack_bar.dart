// lib/utils/snackbar_util.dart

import 'package:flutter/material.dart';
import 'package:hipocapp/product/widget/custom_snackbar/service_snack_bar.dart';

SnackBar createServiceSnackBar(String message) {
  final lower = message.toLowerCase();
  final type = lower.contains('işlem başarılı') ? SnackType.success : SnackType.info;

  return SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: ServiceSnackBar(
      message: message,
      type: type,
    ),
  );
}
