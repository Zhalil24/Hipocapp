import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';

final class EntryListViewState extends Equatable {
  EntryListViewState({required this.isLoading, this.entryListModel = const [], this.entryModel});

  final bool isLoading;
  final List<EntryListModel>? entryListModel;
  final EntryModel? entryModel;

  @override
  List<Object?> get props => [isLoading, entryListModel, entryModel];

  EntryListViewState copyWith({
    bool? isLoading,
    List<LastEntriesModel>? lastEntries,
    List<EntryListModel>? entryListModel,
    EntryModel? entryModel,
  }) {
    return EntryListViewState(
      isLoading: isLoading ?? this.isLoading,
      entryListModel: entryListModel ?? this.entryListModel,
      entryModel: entryModel ?? this.entryModel,
    );
  }
}
