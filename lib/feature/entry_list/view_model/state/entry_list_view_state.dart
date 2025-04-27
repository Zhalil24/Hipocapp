import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';

final class EntryListViewState extends Equatable {
  EntryListViewState({required this.isLoading, this.entryListModel = const []});

  final bool isLoading;
  final List<EntryListModel>? entryListModel;

  @override
  List<Object?> get props => [isLoading, entryListModel];

  EntryListViewState copyWith({bool? isLoading, List<LastEntriesModel>? lastEntries, List<EntryListModel>? entryListModel}) {
    return EntryListViewState(
      isLoading: isLoading ?? this.isLoading,
      entryListModel: entryListModel ?? this.entryListModel,
    );
  }
}
