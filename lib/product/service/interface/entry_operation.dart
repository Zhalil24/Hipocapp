import 'package:gen/gen.dart';

abstract class EntryOperation {
  Future<List<LastEntriesModel>?> getLastEntries();
}
