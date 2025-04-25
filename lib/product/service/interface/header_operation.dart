import 'package:gen/gen.dart';

abstract class HeaderOperation {
  Future<List<HeaderModel>?> getHeaderIdByHeaderName(String name);
}
