import 'package:gen/gen.dart';

abstract class TitleOperation {
  Future<List<TitleModel>?> getAllTitles(int id);
  Future<TitleResponseModel?> searchEntriesByTitleName(String name);
}
