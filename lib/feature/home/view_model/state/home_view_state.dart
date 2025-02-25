import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';

final class HomeViewState extends Equatable {
  HomeViewState(
      {required this.isLoading,
      this.lastEntries = const [],
      this.randomEntries = const [],
      this.isLastEntries = false,
      this.isRandomEntries = false});

  final bool isLoading;
  final bool isLastEntries;
  final bool isRandomEntries;
  final List<LastEntriesModel>? lastEntries;
  final List<RandomEntriesModel>? randomEntries;

  @override
  List<Object?> get props => [isLoading, lastEntries, isLastEntries, isRandomEntries, randomEntries];

  HomeViewState copyWith(
      {bool? isLoading, List<LastEntriesModel>? lastEntries, List<RandomEntriesModel>? randomEntries, bool? isLastEntries, bool? isRandomEntries}) {
    return HomeViewState(
      isLoading: isLoading ?? this.isLoading,
      lastEntries: lastEntries ?? this.lastEntries,
      isLastEntries: isLastEntries ?? this.isLastEntries,
      isRandomEntries: isRandomEntries ?? this.isRandomEntries,
      randomEntries: randomEntries ?? this.randomEntries,
    );
  }
}
