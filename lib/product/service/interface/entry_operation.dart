import 'package:gen/gen.dart';

abstract class LastEntryOperation {
  Future<List<LastEntriesModel>?> getLastEntries();
}

abstract class RandomEntryOperation {
  Future<List<RandomEntriesModel>?> getRandomEntries();
}

abstract class EntryOperation {
  Future<EntryModel?> createEntry(EntryModel entryModel);
}

abstract class EntryListOperation {
  Future<List<EntryListModel>?> getEntryList(String name);
}
