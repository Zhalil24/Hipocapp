import 'package:gen/gen.dart';

abstract class LastEntryOperation {
  Future<List<LastEntriesModel>?> getLastEntries();
}

abstract class RandomEntryOperation {
  Future<List<RandomEntriesModel>?> getRandomEntries();
}
