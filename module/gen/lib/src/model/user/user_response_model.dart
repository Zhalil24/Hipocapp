import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'user_response_model.g.dart';

@JsonSerializable()
class UserResponseModel extends INetworkModel<UserResponseModel> with EquatableMixin {
  final bool? isSuccess;
  @JsonKey(name: "data")
  final User? user;
  final String? message;

  UserResponseModel({this.isSuccess, this.user, this.message});

  factory UserResponseModel.fromJson(Map<String, dynamic> json) => _$UserResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserResponseModelToJson(this);

  @override
  UserResponseModel fromJson(Map<String, dynamic> json) => UserResponseModel.fromJson(json);

  @override
  List<Object?> get props => [isSuccess, user, message];
}
