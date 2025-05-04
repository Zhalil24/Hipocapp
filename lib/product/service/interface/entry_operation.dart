import 'package:gen/gen.dart';

abstract class LastEntryOperation {
  Future<List<LastEntriesModel>?> getLastEntries();
}

abstract class RandomEntryOperation {
  Future<List<RandomEntriesModel>?> getRandomEntries();
}

abstract class EntryOperation {
  Future<EntryResponseModel?> createEntry(EntryModel entryModel);
  Future<EntryResponseModel?> deleteEntry(int id);
}

abstract class EntryListOperation {
  Future<List<EntryListModel>?> getEntryList(String name);
}
