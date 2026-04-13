import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
import 'package:equatable/equatable.dart';

part 'follow_count_model.g.dart';

@JsonSerializable()
class FollowCountModel extends INetworkModel<FollowCountModel> with EquatableMixin {
  FollowCountModel({
    this.userId,
    this.followersCount,
    this.followingCount,
  });

  factory FollowCountModel.fromJson(Map<String, dynamic> json) =>
      _$FollowCountModelFromJson(json);

  final int? userId;
  final int? followersCount;
  final int? followingCount;
  @override
  List<Object?> get props => [userId, followersCount, followingCount];

  @override
  FollowCountModel fromJson(Map<String, dynamic> json) => _$FollowCountModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FollowCountModelToJson(this);

  FollowCountModel copyWith({
    int? userId,
    int? followersCount,
    int? followingCount,
  }) {
    return FollowCountModel(
      userId: userId ?? this.userId,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
    );
  }
}
