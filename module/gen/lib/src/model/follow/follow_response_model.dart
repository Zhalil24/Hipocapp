import 'package:equatable/equatable.dart';
import 'package:gen/src/model/follow/follow_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'follow_response_model.g.dart';

@JsonSerializable()
class FollowResponseModel extends INetworkModel<FollowResponseModel>
    with EquatableMixin {
  FollowResponseModel({this.isSuccess, this.followModel, this.message});

  factory FollowResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FollowResponseModelFromJson(json);

  final bool? isSuccess;
  @JsonKey(name: 'data')
  final FollowModel? followModel;
  final String? message;

  @override
  FollowResponseModel fromJson(Map<String, dynamic> json) =>
      FollowResponseModel.fromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FollowResponseModelToJson(this);

  @override
  List<Object?> get props => [isSuccess, followModel, message];
}
