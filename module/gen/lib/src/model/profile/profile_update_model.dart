import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'profile_update_model.g.dart';

@JsonSerializable()
class ProfileUpdateModel extends INetworkModel<ProfileUpdateModel> with EquatableMixin {
  ProfileUpdateModel({this.id, this.name, this.surname, this.username, this.email, this.photo, this.password, this.passwordRe});

  factory ProfileUpdateModel.fromJson(Map<String, dynamic> json) => _$ProfileUpdateModelFromJson(json);

  final int? id;
  final String? name;
  final String? surname;
  final String? username;
  final String? email;
  final String? password;
  final String? passwordRe;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? photo;
  @override
  List<Object?> get props => [id, name, surname, username, email, photo, password, passwordRe];

  @override
  ProfileUpdateModel fromJson(Map<String, dynamic> json) => _$ProfileUpdateModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProfileUpdateModelToJson(this);

  ProfileUpdateModel copyWith({
    int? id,
    String? name,
    String? surname,
    String? username,
    String? email,
    File? photo,
    String? password,
    String? passwordRe,
  }) {
    return ProfileUpdateModel(
        id: id ?? this.id,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        username: username ?? this.username,
        email: email ?? this.email,
        photo: photo ?? this.photo,
        password: password ?? this.password,
        passwordRe: passwordRe ?? this.passwordRe);
  }
}
