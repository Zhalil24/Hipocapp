import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
import 'package:equatable/equatable.dart';

part 'group_member_model.g.dart';

@JsonSerializable()
class GroupMemberModel extends INetworkModel<GroupMemberModel> with EquatableMixin {
  GroupMemberModel({this.groupId, this.userName, this.userId, this.joinedOn});

  factory GroupMemberModel.fromJson(Map<String, dynamic> json) => _$GroupMemberModelFromJson(json);

  final int? groupId;
  final String? userName;
  final int? userId;
  final String? joinedOn;

  @override
  List<Object?> get props => [groupId, userName, userId, joinedOn];

  @override
  GroupMemberModel fromJson(Map<String, dynamic> json) => _$GroupMemberModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GroupMemberModelToJson(this);

  GroupMemberModel copyWith({
    int? groupId,
    String? userName,
    int? userId,
    String? joinedOn,
  }) {
    return GroupMemberModel(
      groupId: groupId ?? this.groupId,
      userName: userName ?? this.userName,
      userId: userId ?? this.userId,
      joinedOn: joinedOn ?? this.joinedOn,
    );
  }
}
