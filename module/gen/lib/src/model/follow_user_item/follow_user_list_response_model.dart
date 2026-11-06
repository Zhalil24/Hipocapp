import 'package:equatable/equatable.dart';
import 'package:gen/src/model/follow_user_item/follow_user_item_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'follow_user_list_response_model.g.dart';

@JsonSerializable()
class FollowUserListResponseModel
    extends INetworkModel<FollowUserListResponseModel> with EquatableMixin {
  FollowUserListResponseModel({this.isSuccess, this.users, this.message});

  factory FollowUserListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FollowUserListResponseModelFromJson(json);

  final bool? isSuccess;
  @JsonKey(name: 'data')
  final List<FollowUserItemModel>? users;
  final String? message;

  @override
  FollowUserListResponseModel fromJson(Map<String, dynamic> json) =>
      FollowUserListResponseModel.fromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FollowUserListResponseModelToJson(this);

  @override
  List<Object?> get props => [isSuccess, users, message];
}
