import 'package:flutter/foundation.dart';
import 'package:gen/gen.dart';

/// Apilcation  environment manager class
final class AppEnvironment {
  /// General application environment setup
  AppEnvironment.general() {
    _config = kDebugMode ? DevEnv() : ProdEnv();
  }
  static late final AppConfigration _config;
}

/// Get application environment item
enum AppEnvironmentItems {
  /// Network base url
  baseUrl,

  /// Network api key
  apiKey;

  /// Get application environment item value
  String get value {
    try {
      return AppEnvironment._config.baseUrl;
    } catch (e) {
      throw Exception('AppEnvironment is not initalized');
    }
  }
}
