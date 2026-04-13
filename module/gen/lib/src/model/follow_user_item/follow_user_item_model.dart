import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
import 'package:equatable/equatable.dart';

part 'follow_user_item_model.g.dart';

@JsonSerializable()
class FollowUserItemModel extends INetworkModel<FollowUserItemModel> with EquatableMixin {
  FollowUserItemModel({
    this.followerUserId,
    this.followingUserId,
    this.id,
    this.followDate,
    this.followerUserName,
    this.followingUserName,
  });

  factory FollowUserItemModel.fromJson(Map<String, dynamic> json) =>
      _$FollowUserItemModelFromJson(json);

  final int? id;
  final int? followerUserId;
  final int? followingUserId;
  final String? followerUserName;
  final String? followingUserName;
  final DateTime? followDate;

  @override
  List<Object?> get props => [followerUserId, followingUserId, id, followDate, followerUserName, followingUserName];

  @override
  FollowUserItemModel fromJson(Map<String, dynamic> json) => _$FollowUserItemModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FollowUserItemModelToJson(this);

  FollowUserItemModel copyWith({
    int? followerUserId,
    int? followingUserId,
    int? id,
    DateTime? followDate,
    String? followerUserName,
    String? followingUserName,
  }) {
    return FollowUserItemModel(
      followerUserId: followerUserId ?? this.followerUserId,
      followingUserId: followingUserId ?? this.followingUserId,
      id: id ?? this.id,
      followDate: followDate ?? this.followDate,
      followerUserName: followerUserName ?? this.followerUserName,
      followingUserName: followingUserName ?? this.followingUserName,
    );
  }
}
