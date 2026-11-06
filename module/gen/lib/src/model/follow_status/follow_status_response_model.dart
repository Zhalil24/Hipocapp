import 'package:equatable/equatable.dart';
import 'package:gen/src/model/follow_status/follow_status_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'follow_status_response_model.g.dart';

@JsonSerializable()
class FollowStatusResponseModel extends INetworkModel<FollowStatusResponseModel>
    with EquatableMixin {
  FollowStatusResponseModel({
    this.isSuccess,
    this.followStatusModel,
    this.message,
  });

  factory FollowStatusResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FollowStatusResponseModelFromJson(json);

  final bool? isSuccess;
  @JsonKey(name: 'data')
  final FollowStatusModel? followStatusModel;
  final String? message;

  @override
  FollowStatusResponseModel fromJson(Map<String, dynamic> json) =>
      FollowStatusResponseModel.fromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FollowStatusResponseModelToJson(this);

  @override
  List<Object?> get props => [isSuccess, followStatusModel, message];
}
