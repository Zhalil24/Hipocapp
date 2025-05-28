import 'package:equatable/equatable.dart';
import 'package:gen/src/model/user_register/user_register_r_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'user_register_response_model.g.dart';

@JsonSerializable()
class UserRegisterResponseModel extends INetworkModel<UserRegisterResponseModel> with EquatableMixin {
  final bool? isSuccess;
  @JsonKey(name: "data")
  final UserRegisterRModel? userRegisterModel;
  final String? message;

  UserRegisterResponseModel({this.isSuccess, this.userRegisterModel, this.message});

  factory UserRegisterResponseModel.fromJson(Map<String, dynamic> json) => _$UserRegisterResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserRegisterResponseModelToJson(this);

  @override
  UserRegisterResponseModel fromJson(Map<String, dynamic> json) => UserRegisterResponseModel.fromJson(json);

  @override
  List<Object?> get props => [isSuccess, userRegisterModel, message];
}
