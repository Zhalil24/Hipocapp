import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';

final class HomeViewState extends Equatable {
  HomeViewState({required this.isLoading, this.lastEntries = const []});

  final bool isLoading;
  final List<LastEntriesModel>? lastEntries;

  @override
  List<Object?> get props => [isLoading, lastEntries];

  HomeViewState copyWith({bool? isLoading, List<LastEntriesModel>? lastEntries}) {
    return HomeViewState(
      isLoading: isLoading ?? this.isLoading,
      lastEntries: lastEntries ?? this.lastEntries,
    );
  }
}
