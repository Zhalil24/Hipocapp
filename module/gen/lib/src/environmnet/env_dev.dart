import 'package:envied/envied.dart';
import 'package:gen/src/environmnet/app_configration.dart';

part 'env_dev.g.dart';

@Envied(path: 'assets/env/.dev.env', obfuscate: true)
final class DevEnv implements AppConfigration {
  @EnviedField(varName: 'BASE_URL')
  static final String _baseUrl = _DevEnv._baseUrl;

  @override
  String get baseUrl => _baseUrl;
}
