import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';

final class HomeViewState extends Equatable {
  HomeViewState(
      {required this.isLoading,
      this.lastEntries = const [],
      this.groupListModel = const [],
      this.randomEntries = const [],
      this.isLastEntries = false,
      this.isRandomEntries = false,
      this.isLoadingSearchbar = false,
      this.contentType = 'Anasayfa',
      this.titleModel = const [],
      this.contentModel = const []});

  final bool isLoading;
  final bool isLoadingSearchbar;
  final bool isLastEntries;
  final bool isRandomEntries;
  final List<LastEntriesModel>? lastEntries;
  final List<RandomEntriesModel>? randomEntries;
  final List<ContentModel> contentModel;
  final List<TitleModel> titleModel;
  final String contentType;
  final List<GroupListModel>? groupListModel;

  @override
  List<Object?> get props => [
        isLoading,
        lastEntries,
        isLastEntries,
        groupListModel,
        isRandomEntries,
        randomEntries,
        contentType,
        contentModel,
        titleModel,
        isLoadingSearchbar,
      ];

  HomeViewState copyWith(
      {bool? isLoading,
      List<LastEntriesModel>? lastEntries,
      List<RandomEntriesModel>? randomEntries,
      List<GroupListModel>? groupListModel,
      bool? isLastEntries,
      bool? isRandomEntries,
      List<ContentModel>? contentModel,
      List<TitleModel>? titleModel,
      bool? isLoadingSearchbar,
      String? contentType}) {
    return HomeViewState(
        isLoading: isLoading ?? this.isLoading,
        isLoadingSearchbar: isLoadingSearchbar ?? this.isLoadingSearchbar,
        lastEntries: lastEntries ?? this.lastEntries,
        contentType: contentType ?? this.contentType,
        isLastEntries: isLastEntries ?? this.isLastEntries,
        isRandomEntries: isRandomEntries ?? this.isRandomEntries,
        randomEntries: randomEntries ?? this.randomEntries,
        titleModel: titleModel ?? this.titleModel,
        groupListModel: groupListModel ?? this.groupListModel,
        contentModel: contentModel ?? this.contentModel);
  }
}
