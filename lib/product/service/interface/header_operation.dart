import 'package:gen/gen.dart';

abstract class HeaderOperation {
  Future<HeaderModel?> getHeaderIdByHeaderName(String name);
}
