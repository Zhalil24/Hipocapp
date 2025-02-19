import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:logger/logger.dart';
import 'package:my_architecture_template/product/init/config/app_environment.dart';
import 'package:my_architecture_template/product/state/container/product_satate_items.dart';
import 'package:my_architecture_template/product/state/container/product_state_container.dart';

@immutable

/// This class is usedd to initialize the application process
final class ApplicationInitialize {
  /// Project basic required initialize
  Future<void> make() async {
    WidgetsFlutterBinding.ensureInitialized();
    await runZonedGuarded<Future<void>>(
      _initialize,
      (error, stack) {
        Logger().e(error);
      },
    );
  }

  /// This class is usedd to initialize the application process
  static Future<void> _initialize() async {
    await EasyLocalization.ensureInitialized();
    EasyLocalization.logger.enableLevels = [LevelMessages.error];
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await DeviceUtility.instance.initPackageInfo();

    FlutterError.onError = (details) {
      ///crahslytics log instert here
      /// custom service or custom logger insert here
      ///
      /// Todo: add custom logger
      Logger().e(details.exceptionAsString());
    };

    _prodcutEnvironmentWithContainer();
    await ProductStateItems.productCache.init();
  }

  /// Do not change this method
  static void _prodcutEnvironmentWithContainer() {
    AppEnvironment.general();

    /// It must be call after [AppEnvironment.general()]
    ProductStateContainer.setup();
  }
}
