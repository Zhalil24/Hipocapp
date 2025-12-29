import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';

final class GroupListViewState extends Equatable {
  GroupListViewState({
    required this.isLoading,
    this.groupListModel = const [],
  });

  final bool isLoading;
  final List<GroupListModel>? groupListModel;

  @override
  List<Object?> get props => [
        isLoading,
        groupListModel,
      ];

  GroupListViewState copyWith({
    bool? isLoading,
    List<GroupListModel>? groupListModel,
  }) {
    return GroupListViewState(
      isLoading: isLoading ?? this.isLoading,
      groupListModel: groupListModel ?? this.groupListModel,
    );
  }
}
