import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';
import 'package:equatable/equatable.dart';

part 'change_password_model.g.dart';

@JsonSerializable()
class ChangePasswordModel extends INetworkModel<ChangePasswordModel> with EquatableMixin {
  ChangePasswordModel({
    this.password,
    this.newpassword,
    this.newrepassword,
    this.userid,
  });

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) => _$ChangePasswordModelFromJson(json);

  final String? password;
  final String? newpassword;
  final String? newrepassword;
  final int? userid;
  @override
  List<Object?> get props => [
        password,
        newpassword,
        newrepassword,
        userid,
      ];

  @override
  ChangePasswordModel fromJson(Map<String, dynamic> json) => _$ChangePasswordModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChangePasswordModelToJson(this);

  ChangePasswordModel copyWith({
    String? password,
    String? newpassword,
    String? newrepassword,
    int? userid,
  }) {
    return ChangePasswordModel(
      password: password ?? this.password,
      newpassword: newpassword ?? this.newpassword,
      newrepassword: newrepassword ?? this.newrepassword,
      userid: userid ?? this.userid,
    );
  }
}
