import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'user_login_model.g.dart';

@JsonSerializable()

/// User Login Model
class UserLoginModel extends INetworkModel<UserLoginModel> with EquatableMixin {
  UserLoginModel({this.userName, this.password});

  factory UserLoginModel.fromJson(Map<String, dynamic> json) => _$UserLoginModelFromJson(json);
  final String? userName;
  final String? password;

  @override
  List<Object?> get props => [userName, password];

  @override
  UserLoginModel fromJson(Map<String, dynamic> json) {
    return _$UserLoginModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserLoginModelToJson(this);

  UserLoginModel copyWith({
    String? userName,
    String? password,
  }) {
    return UserLoginModel(
      userName: userName ?? this.userName,
      password: password ?? this.password,
    );
  }
}
