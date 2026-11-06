import 'package:equatable/equatable.dart';
import 'package:gen/src/model/follow_count/follow_count_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'follow_count_response_model.g.dart';

@JsonSerializable()
class FollowCountResponseModel extends INetworkModel<FollowCountResponseModel>
    with EquatableMixin {
  FollowCountResponseModel({this.isSuccess, this.followCountModel, this.message});

  factory FollowCountResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FollowCountResponseModelFromJson(json);

  final bool? isSuccess;
  @JsonKey(name: 'data')
  final FollowCountModel? followCountModel;
  final String? message;

  @override
  FollowCountResponseModel fromJson(Map<String, dynamic> json) =>
      FollowCountResponseModel.fromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FollowCountResponseModelToJson(this);

  @override
  List<Object?> get props => [isSuccess, followCountModel, message];
}
