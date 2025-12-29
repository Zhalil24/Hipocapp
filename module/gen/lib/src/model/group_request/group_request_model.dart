import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
import 'package:equatable/equatable.dart';

part 'group_request_model.g.dart';

@JsonSerializable()
class GroupRequestModel extends INetworkModel<GroupRequestModel> with EquatableMixin {
  GroupRequestModel({
    this.groupId,
    this.userId,
    this.requestedOn,
    this.status,
  });

  factory GroupRequestModel.fromJson(Map<String, dynamic> json) => _$GroupRequestModelFromJson(json);

  final int? groupId;
  final int? userId;
  final String? requestedOn;
  final int? status;

  @override
  List<Object?> get props => [
        groupId,
        requestedOn,
        userId,
        status,
      ];

  @override
  GroupRequestModel fromJson(Map<String, dynamic> json) => _$GroupRequestModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GroupRequestModelToJson(this);

  GroupRequestModel copyWith({
    int? groupId,
    int? userId,
    String? createdOn,
    int? status,
  }) {
    return GroupRequestModel(
      groupId: groupId ?? this.groupId,
      userId: userId ?? this.userId,
      requestedOn: requestedOn ?? this.requestedOn,
      status: status ?? this.status,
    );
  }
}
