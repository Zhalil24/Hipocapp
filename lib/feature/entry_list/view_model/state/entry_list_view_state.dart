import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';

final class EntryListViewState extends Equatable {
  EntryListViewState({required this.isLoading, this.entryListModel = const [], this.entryModel, this.serviceResultMessage});

  final bool isLoading;
  final List<EntryListModel>? entryListModel;
  final EntryModel? entryModel;
  final String? serviceResultMessage;

  @override
  List<Object?> get props => [isLoading, entryListModel, entryModel, serviceResultMessage];

  EntryListViewState copyWith({
    bool? isLoading,
    List<LastEntriesModel>? lastEntries,
    List<EntryListModel>? entryListModel,
    EntryModel? entryModel,
    String? serviceResultMessage,
  }) {
    return EntryListViewState(
      isLoading: isLoading ?? this.isLoading,
      entryListModel: entryListModel ?? this.entryListModel,
      entryModel: entryModel ?? this.entryModel,
      serviceResultMessage: serviceResultMessage ?? this.serviceResultMessage,
    );
  }
}
