import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
import 'package:equatable/equatable.dart';

part 'follow_status_model.g.dart';

@JsonSerializable()
class FollowStatusModel extends INetworkModel<FollowStatusModel>
    with EquatableMixin {
  static const Object _sentinel = Object();

  FollowStatusModel({
    this.followerUserId,
    this.followingUserId,
    this.isFollowing,
    this.followDate,
  });

  factory FollowStatusModel.fromJson(Map<String, dynamic> json) =>
      _$FollowStatusModelFromJson(json);

  final int? followerUserId;
  final int? followingUserId;
  final bool? isFollowing;
  final DateTime? followDate;

  @override
  List<Object?> get props =>
      [followerUserId, followingUserId, isFollowing, followDate];

  @override
  FollowStatusModel fromJson(Map<String, dynamic> json) =>
      _$FollowStatusModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FollowStatusModelToJson(this);

  FollowStatusModel copyWith({
    int? followerUserId,
    int? followingUserId,
    bool? isFollowing,
    Object? followDate = _sentinel,
  }) {
    return FollowStatusModel(
      followerUserId: followerUserId ?? this.followerUserId,
      followingUserId: followingUserId ?? this.followingUserId,
      isFollowing: isFollowing ?? this.isFollowing,
      followDate: identical(followDate, _sentinel)
          ? this.followDate
          : followDate as DateTime?,
    );
  }
}
