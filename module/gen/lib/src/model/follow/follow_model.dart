import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
import 'package:equatable/equatable.dart';

part 'follow_model.g.dart';

@JsonSerializable()
class FollowModel extends INetworkModel<FollowModel> with EquatableMixin {
  FollowModel({
    this.followerUserId,
    this.followingUserId,
    this.id,
    this.followDate,
  });

  factory FollowModel.fromJson(Map<String, dynamic> json) =>
      _$FollowModelFromJson(json);

  final int? id;
  final int? followerUserId;
  final int? followingUserId;
  final DateTime? followDate;

  @override
  List<Object?> get props => [followerUserId, followingUserId, id, followDate];

  @override
  FollowModel fromJson(Map<String, dynamic> json) => _$FollowModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FollowModelToJson(this);

  FollowModel copyWith({
    int? followerUserId,
    int? followingUserId,
    int? id,
    DateTime? followDate,
  }) {
    return FollowModel(
      followerUserId: followerUserId ?? this.followerUserId,
      followingUserId: followingUserId ?? this.followingUserId,
      id: id ?? this.id,
      followDate: followDate ?? this.followDate,
    );
  }
}
