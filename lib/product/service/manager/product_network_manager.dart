import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:my_architecture_template/product/init/config/app_environment.dart';
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
  // void listenErrorState({required ValueChanged<int> onErrorStatus}) {
  //   interceptors.add(InterceptorsWrapper(
  //     onError: (error, handler) {
  //       onErrorStatus(error.response?.statusCode ?? HttpStatus.notFound);
  //     },
  //   ));
  // }
  void listenErrorState({required ValueChanged<int> onErrorStatus}) {
    interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print("📌 İstek atılıyor: ${options.uri}");
        print("📌 Header: ${options.headers}");
        print("📌 Body: ${options.data}");
        handler.next(options);
      },
      onResponse: (response, handler) {
        print("✅ Başarılı Yanıt: ${response.data}");
        handler.next(response);
      },
      onError: (error, handler) {
        print("❌ Network Hatası: ${error.message}");
        print("📌 Status Code: ${error.response?.statusCode}");
        print("📌 Response Data: ${error.response?.data}");
        onErrorStatus(error.response?.statusCode ?? HttpStatus.notFound);
        handler.next(error);
      },
    ));
  }
}
