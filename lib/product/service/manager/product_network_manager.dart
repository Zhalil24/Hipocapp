import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:vexana/vexana.dart';

/// Product network manager
final class ProductNetworkManager extends NetworkManager<EmptyModel> {
  ProductNetworkManager.base()
      : super(
          options: BaseOptions(
            //baseUrl: AppEnvironmentItems.baseUrl.value,
            baseUrl: 'http://192.34.63.193/',
          ),
        );

  /// Handle Error
  /// [onErrorStatus] is error status code [HttpStatus]
  void listenErrorState({required ValueChanged<int> onErrorStatus}) {
    interceptors.add(InterceptorsWrapper(
      onError: (error, handler) {
        onErrorStatus(error.response?.statusCode ?? HttpStatus.notFound);
      },
    ));
  }
}
