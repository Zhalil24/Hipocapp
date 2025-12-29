import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
import 'package:equatable/equatable.dart';

part 'group_list_model.g.dart';

@JsonSerializable()
class GroupListModel extends INetworkModel<GroupListModel> with EquatableMixin {
  GroupListModel({this.id, this.groupName, this.createdOn, this.description});

  factory GroupListModel.fromJson(Map<String, dynamic> json) => _$GroupListModelFromJson(json);

  final int? id;
  final String? groupName;
  final String? createdOn;
  final String? description;

  @override
  List<Object?> get props => [id, groupName, createdOn, description];

  @override
  GroupListModel fromJson(Map<String, dynamic> json) => _$GroupListModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GroupListModelToJson(this);

  GroupListModel copyWith({
    int? id,
    String? groupName,
    String? createdOn,
    String? description,
  }) {
    return GroupListModel(
      id: id ?? this.id,
      groupName: groupName ?? this.groupName,
      createdOn: createdOn ?? this.createdOn,
      description: description ?? this.description,
    );
  }
}
