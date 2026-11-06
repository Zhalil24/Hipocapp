import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:vexana/vexana.dart';
import '../../init/config/app_environment.dart';
import '../../state/container/product_satate_items.dart';

/// Product network manager
final class ProductNetworkManager extends NetworkManager<EmptyModel> {
  ProductNetworkManager.base()
      : super(
          options: BaseOptions(
            baseUrl: AppEnvironmentItems.baseUrl.value,
          ),
        ) {
    interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final cachedUser = await ProductStateItems
            .productCache.userCacheOperation
            .get('user_token');
        final token = cachedUser?.token ?? '';
        if (token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    ));
  }

  /// Handle Error
  /// [onErrorStatus] is error status code [HttpStatus]
  void listenErrorState({required ValueChanged<int> onErrorStatus}) {
    interceptors.add(InterceptorsWrapper(
      onError: (error, handler) {
        onErrorStatus(error.response?.statusCode ?? HttpStatus.notFound);
        handler.next(error);
      },
    ));
  }
}
