import 'package:equatable/equatable.dart';
import 'package:gen/src/model/profile/profile_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'profile_response_model.g.dart';

@JsonSerializable()
class ProfileResponseModel extends INetworkModel<ProfileResponseModel> with EquatableMixin {
  final bool? isSuccess;
  @JsonKey(name: "data")
  final ProfileModel? profileModel;
  final String? message;

  ProfileResponseModel({this.isSuccess, this.profileModel, this.message});

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) => _$ProfileResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProfileResponseModelToJson(this);

  @override
  ProfileResponseModel fromJson(Map<String, dynamic> json) => ProfileResponseModel.fromJson(json);

  @override
  List<Object?> get props => [isSuccess, profileModel, message];
}
