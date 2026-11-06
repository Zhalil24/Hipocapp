import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/navigation/app_router.dart';
import 'package:hipocapp/product/state/container/product_satate_items.dart';

///Manege your network view businiess logic
final class ProductNetworkErrorManager {
  ProductNetworkErrorManager({required this.context});

  final BuildContext context;

  /// Several screens listen at once; only the first one redirects.
  static bool _isRedirecting = false;

  Future<void> handleError(int value) async {
    if (value != HttpStatus.unauthorized || _isRedirecting) {
      return;
    }

    _isRedirecting = true;
    try {
      await ProductStateItems.productCache.userCacheOperation
          .remove('user_token');
      if (context.mounted) {
        await AutoRouter.of(context).replaceAll([const LoginRoute()]);
      }
    } finally {
      _isRedirecting = false;
    }
  }
}
