import 'dart:io';

import 'package:flutter/material.dart';

///Manege your network view businiess logic
final class ProductNetworkErrorManager {
  ProductNetworkErrorManager({required this.context});

  final BuildContext context;

  void handleError(int value) {
    if (value == HttpStatus.unauthorized) {
      ///
    }
  }
}
