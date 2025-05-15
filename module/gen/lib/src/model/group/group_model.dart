import 'package:gen/src/model/group_member/group_member_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
import 'package:equatable/equatable.dart';

part 'group_model.g.dart';

@JsonSerializable()
class GroupModel extends INetworkModel<GroupModel> with EquatableMixin {
  GroupModel({this.id, this.groupName, this.createdOn, this.members});

  factory GroupModel.fromJson(Map<String, dynamic> json) => _$GroupModelFromJson(json);

  final int? id;
  final String? groupName;
  final String? createdOn;
  final List<GroupMemberModel>? members;

  @override
  List<Object?> get props => [id, groupName, createdOn, members];

  @override
  GroupModel fromJson(Map<String, dynamic> json) => _$GroupModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GroupModelToJson(this);

  GroupModel copyWith({
    int? id,
    String? groupName,
    List<GroupMemberModel>? members,
    String? createdOn,
  }) {
    return GroupModel(
      id: id ?? this.id,
      groupName: groupName ?? this.groupName,
      createdOn: createdOn ?? this.createdOn,
      members: members ?? this.members,
    );
  }
}
