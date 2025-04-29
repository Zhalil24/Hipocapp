import 'package:gen/gen.dart';

abstract class ContentOperarion {
  Future<List<ContentModel>?> getContentList(String contentType);
}
