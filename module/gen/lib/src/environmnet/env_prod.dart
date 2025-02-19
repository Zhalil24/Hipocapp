import 'package:envied/envied.dart';
import 'package:gen/src/environmnet/app_configration.dart';

part 'env_prod.g.dart';

@Envied(path: 'assets/env/.prod.env', obfuscate: true)
final class ProdEnv implements AppConfigration {
  @EnviedField(varName: 'BASE_URL')
  static final String _baseUrl = _ProdEnv._baseUrl;

  @EnviedField(varName: 'API_KEY')
  static final String _apiKey = _ProdEnv._apiKey;

  @override
  String get apiKey => _apiKey;

  @override
  String get baseUrl => _baseUrl;
}
