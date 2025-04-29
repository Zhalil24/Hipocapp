import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';

final class HomeViewState extends Equatable {
  HomeViewState(
      {required this.isLoading,
      this.lastEntries = const [],
      this.randomEntries = const [],
      this.isLastEntries = false,
      this.isRandomEntries = false,
      this.contentType = 'Anasayfa',
      this.contentModel = const []});

  final bool isLoading;
  final bool isLastEntries;
  final bool isRandomEntries;
  final List<LastEntriesModel>? lastEntries;
  final List<RandomEntriesModel>? randomEntries;
  final List<ContentModel> contentModel;
  final String contentType;

  @override
  List<Object?> get props => [isLoading, lastEntries, isLastEntries, isRandomEntries, randomEntries, contentType, contentModel];

  HomeViewState copyWith(
      {bool? isLoading,
      List<LastEntriesModel>? lastEntries,
      List<RandomEntriesModel>? randomEntries,
      bool? isLastEntries,
      bool? isRandomEntries,
      List<ContentModel>? contentModel,
      String? contentType}) {
    return HomeViewState(
        isLoading: isLoading ?? this.isLoading,
        lastEntries: lastEntries ?? this.lastEntries,
        contentType: contentType ?? this.contentType,
        isLastEntries: isLastEntries ?? this.isLastEntries,
        isRandomEntries: isRandomEntries ?? this.isRandomEntries,
        randomEntries: randomEntries ?? this.randomEntries,
        contentModel: contentModel ?? this.contentModel);
  }
}
